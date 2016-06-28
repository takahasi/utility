#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <linux/joystick.h>

#define BUTTON_DATA_MAX 8
#define STICK_DATA_MAX 6
#define INPUT_DEVICE "/dev/input/js0"

#define THRESHOLD_H (15000)
#define THRESHOLD_L (-15000)

int main()
{
    /* open as input device */
    int fd = open(INPUT_DEVICE, O_RDONLY);

    while (1) {
        struct js_event  event;

        if (read(fd, &event, sizeof(struct js_event)) >= sizeof(struct js_event)) {
            switch (event.type & (~JS_EVENT_INIT)) {
            case JS_EVENT_BUTTON:
                if (event.number < BUTTON_DATA_MAX) {
                    printf("BUTTON[%d]=%d\n", event.number, event.value);
                }
                break;
            case JS_EVENT_AXIS:
                if (event.number < STICK_DATA_MAX) {
                    //printf("AXIS[%d]=%d\n", event.number, event.value);
                    switch (event.number) {
                    case 0: /* Pan L/R */
                        if (event.value >= THRESHOLD_H) {
                            printf("Pan LEFT\n");
                        }
                        else if (event.value <= THRESHOLD_L) {
                            printf("Pan RIGHT\n");
                        }
                        break;
                    case 1: /* Zoom */
                        if (event.value >= THRESHOLD_H) {
                            printf("Zoom LEFT\n");
                        }
                        else if (event.value <= THRESHOLD_L) {
                            printf("Zoom RIGHT\n");
                        }
                        break;
                    case 2: /* Pan U/D */
                        if (event.value >= THRESHOLD_H) {
                            printf("Pan DOWN\n");
                        }
                        else if (event.value <= THRESHOLD_L) {
                            printf("Pan UP\n");
                        }
                        break;
                    case 3: /* Tilt */
                        if (event.value >= THRESHOLD_H) {
                            printf("Tilt DOWN\n");
                        }
                        else if (event.value <= THRESHOLD_L) {
                            printf("Tilt UP\n");
                        }
                        break;
                    case 4: /* Roll */
                        if (event.value >= THRESHOLD_H) {
                            printf("Roll LEFT\n");
                        }
                        else if (event.value <= THRESHOLD_L) {
                            printf("Roll RIGHT\n");
                        }
                        break;
                    case 5: /* Spin */
                        if (event.value >= THRESHOLD_H) {
                            printf("Spin LEFT\n");
                        }
                        else if (event.value <= THRESHOLD_L) {
                            printf("Spin RIGHT\n");
                        }
                        break;
                    default:
                        break;
                    }
                }
                break;
            }
        }
    }
    close(fd);
}
