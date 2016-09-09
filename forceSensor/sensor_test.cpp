/*!
 * @file   sensor_test.cpp
 * @brief  test program for force sensor
 * @author takahashi
 * @sa
 * @date   2016/09/09 New
 * @version    1.0
 */
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <string.h>
#include <time.h>
#include "sensor_test.h"

void init(void)
{
    init_wacoh_udynpick();
}

void setup(void)
{
    setup_wacoh_udynpick();
}

void finalize(void)
{
    finalize_wacoh_udynpick();
}

void get_data(_sensor_data *s)
{
    get_data_wacoh_udynpick(s);
}

void show_data(_sensor_data *s)
{
    show_data_wacoh_udynpick(s);
}

int main(int argc, char *argv[])
{
    init();
    setup();

    while (1) {
        _sensor_data s;
        get_data(&s);
        show_data(&s);
        usleep(1000 * 500);
    }

    finalize();

    return 0;
}
