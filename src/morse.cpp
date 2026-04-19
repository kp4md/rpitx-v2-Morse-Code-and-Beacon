#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <stdarg.h>
#include <stdint.h>
#include <math.h>
#include <time.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <ctype.h>
#include <string>
#include <librpitx/librpitx.h>

#define MORSECODES 55

typedef struct morse_code
{
    uint8_t ch;
    const char dits[8];   // no padding spaces anymore
} Morsecode;

/* ================= Morse Table (NO SPACES!) ================= */

const Morsecode code_table[] =
{
    {' ', ""},   // handled separately

    // Numbers
    {'0', "-----"},
    {'1', ".----"},
    {'2', "..---"},
    {'3', "...--"},
    {'4', "....-"},
    {'5', "....."},
    {'6', "-...."},
    {'7', "--..."},
    {'8', "---.."},
    {'9', "----."},

    // Letters
    {'A', ".-"},
    {'B', "-..."},
    {'C', "-.-."},
    {'D', "-.."},
    {'E', "."},
    {'F', "..-."},
    {'G', "--."},
    {'H', "...."},
    {'I', ".."},
    {'J', ".---"},
    {'K', "-.-"},
    {'L', ".-.."},
    {'M', "--"},
    {'N', "-."},
    {'O', "---"},
    {'P', ".--."},
    {'Q', "--.-"},
    {'R', ".-."},
    {'S', "..."},
    {'T', "-"},
    {'U', "..-"},
    {'V', "...-"},
    {'W', ".--"},
    {'X', "-..-"},
    {'Y', "-.--"},
    {'Z', "--.."},

    // Punctuation
    {'.', ".-.-.-"},
    {',', "--..--"},
    {'?', "..--.."},
    {'/', "-..-."},
    {'=', "-...-"},
    {'+', ".-.-."},
    {'-', "-....-"},
    {'(', "-.--."},
    {')', "-.--.-"},
    {':', "---..."},
    {';', "-.-.-."},
    {'\'', ".----."},
    {'"', ".-..-."},
    {'@', ".--.-."},
    {'!', "-.-.--"}
};

/* ================= Morse ? CW Bitstream ================= */

std::string morse_to_cw(const char * dits)
{
    std::string cw;
    int len = strlen(dits);

    for (int i = 0; i < len; i++)
    {
        if (dits[i] == '.')
        {
            cw += "1";
        }
        else if (dits[i] == '-')
        {
            cw += "111";
        }

        // Add intra-element gap IF NOT last element
        if (i < len - 1)
        {
            cw += "0";
        }
    }

    return cw;
}

/* ================= Send OOK ================= */

void Send_CW_OOK(const float freq, float wpm, const std::string &cw)
{
    float dot_ms = 1200.0f / wpm;
    float symbolrate = 1000.0f / dot_ms;

    int FifoSize = cw.length();
    float upsample = 100.0f;

    ookburst ook(freq, symbolrate, 14, FifoSize, upsample);

    unsigned char *TabSymbol = new unsigned char[FifoSize];

    for (int i = 0; i < FifoSize; i++)
    {
        TabSymbol[i] = (cw[i] == '1') ? 1 : 0;
    }

    ook.SetSymbols(TabSymbol, FifoSize);

    delete[] TabSymbol;
}

/* ================= Lookup ================= */

const char * text_to_morse(char txt)
{
    char tch = toupper(txt);

    for (int j = 0; j < MORSECODES; j++)
    {
        if (code_table[j].ch == tch)
        {
            return code_table[j].dits;
        }
    }

    return nullptr;
}

/* ================= MAIN ================= */

int main(int argc, char * argv[])
{
    if (argc < 4)
    {
        printf("usage: ./morse freq(Hz) WPM MSG(\"quoted\")\n");
        exit(0);
    }

    float freq = atof(argv[1]);
    float wpm  = atof(argv[2]);
    const char * msg = argv[3];

    printf("msg: %s\n", msg);

    std::string full_cw;

    for (int i = 0; i < strlen(msg); i++)
    {
        if (msg[i] == ' ')
        {
            // word gap = 7 zeros
            full_cw += "0000000";
            continue;
        }

        const char *dits = text_to_morse(msg[i]);
        if (!dits) continue;

        std::string cw = morse_to_cw(dits);

        printf("msg[%02d]: %c\tmorse[%s]\tcw[%s]\n",
               i, toupper(msg[i]), dits, cw.c_str());

        full_cw += cw;

        // character gap = 3 zeros
        // BUT avoid adding after last character or before space
        if (i < strlen(msg) - 1 && msg[i+1] != ' ')
        {
            full_cw += "000";
        }
    }

    Send_CW_OOK(freq, wpm, full_cw);

    return 0;
}