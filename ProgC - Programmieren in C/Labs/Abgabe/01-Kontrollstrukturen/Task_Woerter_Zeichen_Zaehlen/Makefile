# what to produce
TARGET        := bin/Task_Woerter_Zeichen_Zaehlen

# implementation files
SOURCES       := src/main.c

# test implementations
TSTSOURCES    := tests/tests.c

# directories to create (and remove upon cleanup)
CREATEDIRS    := bin doc

# list of derived file names from the source names
OBJECTS       := $(SOURCES:%.c=%.o)    # list of gcc -c  ... produced *.o files
DEPS          := $(SOURCES:%.c=%.d)    # list of gcc -MD ... produced *.d files
TSTOBJECTS    := $(TSTSOURCES:%.c=%.o) # list of gcc -c  ... produced *.o files
TSTDEPS       := $(TSTSOURCES:%.c=%.d) # list of gcc -MD ... produced *.d files
TSTTARGET     := $(CURDIR)/tests/runtest

# libraries
CUNITINCDIR   := $(CURDIR)/../../../CUnit/include
CUNITLIBDIR   := $(CURDIR)/../../../CUnit/lib
TSTINCDIR     := $(CURDIR)/../../../include
TSTLIBDIR     := $(CURDIR)/../../../lib

# full path to the target
FULLTARGET    := $(CURDIR)/$(TARGET)

# commands and flags
CC            = gcc
CFLAGS        = -std=c99 -Wall -g
CPPFLAGS      = -MD -Isrc -Itests -I$(TSTINCDIR) -I$(CUNITINCDIR) -DTARGET=$(FULLTARGET)
LDFLAGS       = -static -z muldefs 

# targets which get always visited (without checking any up-to-date state)
.PHONY: default clean test doc mkdir

# targets
default: $(FULLTARGET)
	@echo "#### $< built ####"

$(FULLTARGET): mkdir $(OBJECTS) Makefile
	$(LINK.c) -o $@ $(OBJECTS)

clean:
	$(RM) $(TARGET) $(OBJECTS) $(DEPS) $(TSTTARGET) $(TSTOBJECTS) $(TSTDEPS) $(wildcard */*~ *~ tests/*.txt)
	$(RM) -r $(CREATEDIRS)
	@echo "#### $@ done ####"

doc:
	doxygen ../Doxyfile > /dev/null
	@echo "#### $@ done ####"

test: $(TSTTARGET)
	(cd tests; $(TSTTARGET))
	@echo "#### $< executed ####"

$(TSTTARGET): $(FULLTARGET) $(TSTOBJECTS)
	$(LINK.c) -o $(TSTTARGET) $(TSTOBJECTS) $(OBJECTS) -L$(CUNITLIBDIR) -lcunit -L$(TSTLIBDIR) -lprogctest
	@echo "#### $@ built ####"


# create needed directories (ignoring any error)
mkdir:
	-mkdir -p $(CREATEDIRS)

# read in the gcc -MD ... produced dependencies (ignoring any error)
-include $(DEPS) $(TSTDEPS)
