/*!
 * @file   sensor_wacoh_udynpick.cpp
 * @brief  test program for force sensor
 * @author takahashi
 * @sa
 * @date   2016/09/09 New
 * @version    1.0
 */
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>
#include <termios.h>
#include <time.h>
#include "sensor_test.h"

#define DEV_NAME    "/dev/ttyUSB0"
#define BAUD_RATE    B921600
#define BUFF_SIZE    (4096)

int fd = -1;

void init_wacoh_udynpick(void)
{
    fd = open(DEV_NAME, O_RDWR | O_NOCTTY | O_NONBLOCK);
    if (fd < 0) {
        return;
    }

    struct termios tio;
    memset(&tio, 0, sizeof(tio));
    tio.c_cflag = (BAUD_RATE | CS8 | CLOCAL | CREAD);
    tio.c_cc[VTIME] = 0;
    cfsetispeed(&tio, BAUD_RATE);
    cfsetospeed(&tio, BAUD_RATE);
    tcsetattr(fd,TCSANOW,&tio);
}

void setup_wacoh_udynpick(void)
{
    /* waits for stabiliz ing */
    sleep(5);

    /* set offset as initial values */
    write(fd, "O", 1);
    write(fd, "O", 1);
    write(fd, "O", 1);
    sleep(1);

    /* set low pass filter */
    write(fd, "8F", 2); /* 8F:8-points average */
    sleep(1);

    /* dummy read to set initial offset */
    write(fd, "R", 1);
    sleep(1);
}

void finalize_wacoh_udynpick(void)
{
    close(fd);
}

static void filter(_sensor_data *now, _sensor_data *prev)
{
    for (int i = 0; i < AXIS_NUM; i++) {
        //now->data[i] = ((prev->data[i] * 0.8) + (now->data[i] *0.2));
    }
}

void get_data_wacoh_udynpick(_sensor_data *s)
{
    static _sensor_data prev_s = {0};
    char str[27];

    /* read values */
    write(fd, "R", 1);

    int len = read(fd, &str, sizeof(str));
    if (len < 0) {
        return;
    }
    sscanf(str, "%1d%4hx%4hx%4hx%4hx%4hx%4hx",
            &s->tick,
            &s->data[0],
            &s->data[1],
            &s->data[2],
            &s->data[3],
            &s->data[4],
            &s->data[5]); 
    filter(s, &prev_s);

    memcpy(&prev_s, s, sizeof(prev_s));
}

void show_data_wacoh_udynpick(_sensor_data *s)
{
    printf("[%d] ", s->tick); 
    for (int i = 0; i < AXIS_NUM; i++) {
        printf("%d,", s->data[i]);
    }
    printf("\n");
}
