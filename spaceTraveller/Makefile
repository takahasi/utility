CC=gcc
RM=rm
CFLAGS=-Wall -O2

PROGRAM=spaceTraveller
OBJS=spaceTraveller.o

.SUFFIXES: .c .o

$(PROGRAM):$(OBJS)
	$(CC) -o $(PROGRAM) $^

.c.o:
	$(CC) $(CFLAGS) -c $<

.PHONY: clean
clean:
	$(RM) $(PROGRAM) $(OBJS)
