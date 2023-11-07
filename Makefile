CC = gcc # Compiler
CFLAGS = -Wall -g -fno-stack-protector # Compiler flags
TARGET = main # Executable name
SRCS = main.c # Source files
OBJS = $(SRCS:.c=.o) # Object files

all: $(TARGET)

$(TARGET): $(OBJS) # Link object files
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.c # Compile source files
	$(CC) $(CFLAGS) -c $<

clean: # Remove all object files and executable
	rm -f $(TARGET) $(OBJS)

.PHONY: all clean # Not file names
