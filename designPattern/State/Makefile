CC=g++
RM=rm
CFLAGS=-Wall -O2

PROGRAM=state
OBJS=state.o

.SUFFIXES: .cpp .o

$(PROGRAM):$(OBJS)
	$(CC) -o $(PROGRAM) $^

.cpp.o:
	$(CC) $(CFLAGS) -c $<

.PHONY: clean
clean:
	$(RM) $(PROGRAM) $(OBJS)
