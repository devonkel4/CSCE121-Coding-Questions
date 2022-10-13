CXX=g++
CXXFLAGS=-std=c++17 -g -pedantic -Wall -Wextra -Werror -fno-omit-frame-pointer
#-fsanitize=address,undefined
LDLIBS=


SRCS=Runner.cpp
DEPS=Calculator.cpp
BINS=$(SRCS:%.cpp=%.exe)
OBJS=$(DEPS:%.cpp=%.o)


all: clean $(BINS)

%.o: %.cpp %.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

%.exe: %.cpp $(OBJS)
	$(CXX) $(CXXFLAGS) -o $(patsubst %.exe,%,$@) $^ $(LDLIBS)


.PHONY: clean test

clean:
	rm -f schedule out.trace ./test-files/cmd*.txt

test: all
	chmod u+x autograde_exceptions.sh
	./autograde_exceptions.sh