CC=g++
RM=rm
CFLAGS=-Wall -O2

PROGRAM=sensor_test
OBJS=sensor_test.o
OBJS+=sensor_wacoh_udynpick.o

.SUFFIXES: .c .o

$(PROGRAM):$(OBJS)
	$(CC) -o $(PROGRAM) $^

.c.o:
	$(CC) $(CFLAGS) -c $<

.PHONY: clean
clean:
	$(RM) $(PROGRAM) $(OBJS)
