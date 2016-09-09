/*!
 * @file   sensor_test.h
 * @brief  test program for force sensor
 * @author takahashi
 * @sa
 * @date   2016/09/09 New
 * @version    1.0
 */
#define AXIS_NUM     (6)

typedef struct _sensor_data {
    int tick;
    unsigned short data[AXIS_NUM];
} SENSOR_DATA;

void init(void);
void setup(void);
void finalize(void);
void get_data(_sensor_data *s);
void show_data(_sensor_data *s);

void init_wacoh_udynpick(void);
void setup_wacoh_udynpick(void);
void finalize_wacoh_udynpick(void);
void get_data_wacoh_udynpick(_sensor_data *s);
void show_data_wacoh_udynpick(_sensor_data *s);
