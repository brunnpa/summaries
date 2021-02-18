# BSY Praktikum 06 - Treiber

## Aufgabe 1

### a)

Legen sie zwei Device Files (char device) im Verzeichnis /dev mit mknod an (siehe auch Abschnitt
4.1.3 und man-Pages).

- Namen: MemDev0 und MemDev1
- Major-Nummer: 120
- Minor-Nummer: 0 bzw. 1

Setzen sie die Dateizugriffsrechte wie folgt: chmod 766 /dev/MemDev0 (bzw. /dev/MemDev1).
Hinweis: nach einem Neustart des Systems m¨ussen die Device Files erneut angelegt werden.


````
mknod /dev/MemDev0 c 120 0
mknod /dev/MemDev1 c 120 1
chmod 766 /dev/MemDev0
chmod 766 /dev/MemDev1

````

### b)

Übersetzen sie den Treiber im Verzeichnis aufgabe1 mit make und ebenfalls das Testprogramm
DriverTest.c in Verzeichnis ./tests/DriverTest.

````
root@securitylab-ubuntu:/home/user/Desktop/Treiber/aufgabe1# make
root@securitylab-ubuntu:/home/user/Desktop/Treiber/tests/driverTest# make
````

### c)

````
root@securitylab-ubuntu:/home/user/Desktop/Treiber/aufgabe1# insmod MemDriver.ko
````

### d)

Kontrollieren sie mit den nachfolgenden Befehlen, ob und wie das Modul installiert ist:

````
more /proc/devices
lsmod
````

Welche Informationen können sie aus den Befehlen bzw. Files lesen?

````
root@securitylab-ubuntu:/home/user/Desktop/Treiber/aufgabe1# more /proc/devices | grep MemDriver
120 MemDriver
````

**more /proc/devices**:

/proc/devices. The output from /proc/devices includes the major number and name of the device, and is broken into two major sections: Character devices and Block devices. Character devices are similar to block devices, except for two basic differences: Character devices do not require buffering.

**lsmod**:

lsmod is a command on Linux systems. It shows which loadable kernel modules are currently loaded.


### e)

Testen sie den Treiber mit DriverTest. Das Programm und der Treiber geben einfache Statusmeldungen
aus. Sie verstehen die Meldungen, wenn sie den Programmcode des Treibers und
des Testprogramms analysieren. Was stellen sie bez¨ uglich zeitlicher Reihenfolge der Meldungen
fest? Werden alle Meldungen dargestellt (vor allem die des Treiber)?

Hinweis: DriverTest akzeptiert als Parameter den Namen eines Devices, z.B. /dev/MemDev1
und bzw. oder einen String zwischen ” ”. Werden keine Parameter ¨ubergeben, wird der Default-
Device /dev/MemDev0 verwendet, ebenso ein vordefinierter Text.


````
root@securitylab-ubuntu:/home/user/Desktop/Treiber/tests/driverTest# ./driverTest.e /dev/MemDev1

--> device: /dev/MemDev1
--> string: I am going to the data buffer, follow me !


--> writing to /dev/MemDev1(3): I am going to the data buffer, follow me !


--> filling local string with "------------------------------------------"

--> sleeping for 3 seconds

--> reading from /dev/MemDev1 . . .
--> just read 43 characters: I am going to the data buffer, follow me !


root@securitylab-ubuntu:/home/user/Desktop/Treiber/tests/driverTest# ./driverTest.e /dev/MemDev0

--> device: /dev/MemDev0
--> string: I am going to the data buffer, follow me !


--> writing to /dev/MemDev0(3): I am going to the data buffer, follow me !


--> filling local string with "------------------------------------------"

--> sleeping for 3 seconds

--> reading from /dev/MemDev0 . . .
--> just read 43 characters: I am going to the data buffer, follow me !


root@securitylab-ubuntu:/home/user/Desktop/Treiber/tests/driverTest# 
````

````
May 19 11:04:50 securitylab-ubuntu kernel: [ 2600.556042] we are in the OPEN
May 19 11:04:56 securitylab-ubuntu kernel: [ 2606.594424] we are in RELEASE
May 19 11:05:10 securitylab-ubuntu kernel: [ 2621.086209] we are in the OPEN
May 19 11:05:16 securitylab-ubuntu kernel: [ 2627.105719] we are in RELEASE
````

Nein, die Meldungen des Treibers werden nicht dargestellt.


### f)

Testen sie den Treiber zus¨ atzlich mit folgenden Befehlen:

````
ls -l > /dev/MemDev0
cat /dev/MemDev0
ls -l > /dev/MemDev1
cat /dev/MemDev1
````

Was stellen sie fest ? Was sind mögliche Ursachen für diesen Effekt (Hinweis: welche Information
liefert der Treiber sehr wahrscheinlich nicht) ?

````
May 19 11:17:12 securitylab-ubuntu kernel: [ 3342.715928] we are in the OPEN
May 19 11:17:20 securitylab-ubuntu kernel: [ 3350.960218] we are in RELEASE
May 19 11:17:25 securitylab-ubuntu kernel: [ 3355.956554] we are in the OPEN
May 19 11:17:25 securitylab-ubuntu kernel: [ 3355.957778] we are in RELEASE
May 19 11:17:32 securitylab-ubuntu kernel: [ 3362.929784] we are in the OPEN
May 19 11:17:42 securitylab-ubuntu kernel: [ 3372.766537] we are in RELEASE
````

Die Ausgabe mittels "cat /dev/MemDev1" und "cat /dev/MemDev0" führt zu einer Endlosschleife.

````
...

total 32
-rw-r--r-- 1 user user  1993 Sep  5  2019 driverTest.c
-rwxr-xr-x 1 root root 13040 Mai 19 10:46 driverTest.e
-rw-r--r-- 1 root root  4576 Mai 19 10:46 driverTest.o
-rw-r--r-- 1 user user   277 Sep  5  2019 makefile
total 32
-rw-r--r-- 1 user user  1993 Sep  5  2019 driverTest.c
-rwxr-xr-x 1 root root 13040 Mai 19 10:46 driverTest.e
-rw-r--r-- 1 root root  4576 Mai 19 10:46 driverTest.o
-rw-r--r-- 1 user user   277 Sep  5  2019 makefile
total 32
-rw-r--r-- 1 user user  1993 Sep  5  2019 driverTest.c
-rwxr-xr-x 1 root root 13040 Mai 19 10:46 driverTest.e
-rw-r--r-- 1 root root  4576 Mai 19 10:46 driverTest.o
-rw-r--r-- 1 user user   277 Sep  5  2019 makefile
total 32
-rw-r--r-- 1 user user  1993 Sep  5  2019 driverTest.c
-rwxr-xr-x 1 root root 13040 Mai 19 10:46 driverTest.e
-rw-r--r-- 1 root root  4576 Mai 19 10:46 driverTest.o
-rw-r--r-- 1 user user   277 Sep  5  2019 makefile
total 32
-rw-r--r-- 1 user user  1993 Sep  5  2019 driverTest.c
-rwxr-xr-x 1 root root 13040 Mai 19 10:46 driverTest.e
-rw-r--r-- 1 root root  4576 Mai 19 10:46 driverTest.o

...
````

## Aufgabe 2

### a)

Ändern sie den Treiber so, dass die Daten pro Zugriff (nach dem O¨ ffnen des Devices) nur
noch einmal ausgelesen werden, aber trotzdem nicht verloren gehen. Der Treiber muss mit
DriverTest und den Befehlen ls und more funktionieren.
Hinweis:
Verwenden sie f ¨ ur die Implementierung den Parameter loff t *offset, der bei jedem Aufruf
von MemRead() (bzw. dem Filesytem) die entsprechende Offsetposition enth¨ alt. Beachten sie,
dass sie die neue Offsetposition selbst berechnen und in offset zur¨uckgeben m¨ussen.


````
root@securitylab-ubuntu:/home/user/Desktop/Treiber/aufgabe1# make
make -C /lib/modules/4.15.0-54-generic/build M=/home/user/Desktop/Treiber/aufgabe1 modules
make[1]: Entering directory '/usr/src/linux-headers-4.15.0-54-generic'
Makefile:976: "Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel"
  CC [M]  /home/user/Desktop/Treiber/aufgabe1/MemDriver.o
  Building modules, stage 2.
  MODPOST 1 modules
  CC      /home/user/Desktop/Treiber/aufgabe1/MemDriver.mod.o
  LD [M]  /home/user/Desktop/Treiber/aufgabe1/MemDriver.ko
make[1]: Leaving directory '/usr/src/linux-headers-4.15.0-54-generic'
root@securitylab-ubuntu:/home/user/Desktop/Treiber/aufgabe1# 
root@securitylab-ubuntu:/home/user/Desktop/Treiber/aufgabe1# ll
total 164
drwxr-xr-x 3 user user  4096 Mai 19 11:33 ./
drwxr-xr-x 8 user user  4096 Mai 15  2019 ../
-rw-r--r-- 1 root root 54695 Mai 19 10:46 .cache.mk
-rw-r--r-- 1 user user   428 Sep  5  2019 Makefile
-rw-r--r-- 1 user user  3964 Mai 19 11:33 MemDriver.c
-rw-r--r-- 1 user user  1026 Sep  5  2019 MemDriver.h
-rw-r--r-- 1 root root  6264 Mai 19 11:33 MemDriver.ko
-rw-r--r-- 1 root root   305 Mai 19 11:33 .MemDriver.ko.cmd
-rw-r--r-- 1 root root 29933 Mai 19 11:33 .MemDriver.mod.o.cmd
-rw-r--r-- 1 root root 36357 Mai 19 11:33 .MemDriver.o.cmd
-rw-r--r-- 1 root root    56 Mai 19 11:33 modules.order
-rw-r--r-- 1 root root     0 Mai 19 10:46 Module.symvers
drwxr-xr-x 2 root root  4096 Mai 19 11:33 .tmp_versions/
root@securitylab-ubuntu:/home/user/Desktop/Treiber/aufgabe1# rmmod MemDriver
root@securitylab-ubuntu:/home/user/Desktop/Treiber/aufgabe1# 
root@securitylab-ubuntu:/home/user/Desktop/Treiber/aufgabe1# insmod MemDriver.ko 
root@securitylab-ubuntu:/home/user/Desktop/Treiber/aufgabe1# 

````


### b)

Erweitern sie den Treiber so, dass beim Schreiben auf /dev/MemDev1 alle Kleinbuchstaben in
Grossbuchstaben umgewandelt werden (und auch so gespeichert werden). Denken sie daran,
dass sich /dev/MemDev0 und /dev/MemDev1 nur in der Minor-Nummer unterscheiden.
Implementieren sie dazu eine entsprechende write()-Funktionen (z.B. MemWrite0() und
MemWrite1()) und speichern sie beim O¨ ffnen des Devices diese Funktionen in der File Operations
Table. Weitere Informationen finden sie in Abschnitt 4.4.2 und in [1].



**MemDriver.h**
````
/******************************************************************************
* Memory Device Driver
* 
* Author:       M. Thaler,  A. Schmid
* File:         MemDriver.h
* Grundversion: 17.9.1999   A. Schmid
* Erweiterung, 
* Anpassungen:  25.11.2001  M. Thaler
*               14.02.2010  M. Thaler
*               20.01.2011  M. Thaler
*               23.05.2013  M. Thaler
*               20.05.2016  M. Thaler
* Version:      v.fs20
******************************************************************************/

#define MY_MAJOR 120        /* experimental MAJOR: 120 - 127*/

typedef struct {
    int  length;
    void *buffer;
} dbuf_t;


int     MemOpen(struct inode*, struct file*);
int     MemRelease(struct inode*, struct file*);
ssize_t MemRead(struct file *filp, char *buf, size_t count, loff_t *anything);
ssize_t MemWrite(struct file *filp, const char *buf, 
                                    size_t count, loff_t *anything);
ssize_t MemWriteInUppercase(struct file *filp, const char *buf, 
                                    size_t count, loff_t *anything);

/*****************************************************************************/
````

**MemDriver.c**
````
/*************************************************************************
* Memory Device Driver (Aufgabe 1)
* 
* Author:       M. Thaler, A. Schmid
* File:         MemDriver.c
* Grundversion: 17.9.1999     A. Schmid
* Erweiterung, 
* Anpassungen:  25.11.2001    M. Thaler
*               27.08.2004    M. Thaler    -->> Kernel 2.6
*                - slab.h
*                - deviceOpen: handles number of opens
*                - include files adapated
*               14.02.2010  M. Thaler
*                - try_moudle_get/module_put: new USE_COUNT
*               20.01.2011  M. Thaler
*                - autoconf.h removed
*               23.05.2013  M. Thaler
*                - removed: <asm/system.h>, try_get_module() and module_put()
*               14.05.2016  M. Thaler
*                - printk("<0>..") to printk(KERN_ALERT "...)
*               20.05.2016  M. Thaler
*                - naming changed
*               05.05.2018  M. Thaler: new -> #include <linux/uaccess.h>
*               20.05.2020  tha, commented out prinkt() ... may fill disk
* Version:      v.fs20
***************************************************************************/

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/fs.h>
#include <linux/uaccess.h>

#include "MemDriver.h"

MODULE_LICENSE("GPL");

/*-----------------------------------------------------------------------*/
/* using struct intialization of C99 (and GNU) -> portable               */

static struct file_operations MemFops = {
  .owner    = THIS_MODULE,
  .open     = MemOpen,
  .release  = MemRelease,
  .read     = MemRead,
  .write    = MemWrite,
};

static dbuf_t datBuf = {0, NULL};

static int deviceOpen = 0;

/*-----------------------------------------------------------------------*/

int init_module(void) {
    int res;
    printk(KERN_ALERT "Hello from Module\n");
    deviceOpen = 0;
    res = register_chrdev(MY_MAJOR, "MemDriver", &MemFops);
    if (res < 0)
        printk(KERN_ALERT "cannot register MemDriver");
    return(res);
}

void cleanup_module(void) {
    printk(KERN_ALERT "bye bye\n");
    if (datBuf.buffer != NULL)
        kfree(datBuf.buffer);
    unregister_chrdev(MY_MAJOR, "MemDriver");
}

/*-----------------------------------------------------------------------*/

int MemOpen(struct inode *inode, struct file *filp) {
    printk(KERN_ALERT "we are in the OPEN\n");
    if (deviceOpen != 0)                /* check if not already in use */
        return(-EBUSY);                 /* if yes return with error    */
    else
        deviceOpen++;

    filp->private_data = &datBuf;

    // set matching write fn
    if (MINOR(inode->i_rdev) == 0)
        MemFops.write = MemWrite;
    else
        MemFops.write = MemWriteInUppercase;

    return(0);
}

int MemRelease(struct inode *inode, struct file *filp) {
    printk(KERN_ALERT "we are in RELEASE\n");
    deviceOpen--;
    return(0);
}

ssize_t MemRead(struct file *filp, char *buf, size_t count, loff_t *offset) {
    size_t lcount;
    dbuf_t *mem;
    printk(KERN_ALERT "we are in the READ\n");    
    mem = filp->private_data;

    // if offset + what you whish to read is bigger than memory
    if ((*offset + count) > mem->length)
        lcount = mem->length - *offset;
    else
        lcount = count;

    // set new offset position
    *offset = *offset + lcount;

    if (copy_to_user(buf, mem->buffer, lcount) != 0)
        lcount = -1;
    
    return(lcount);
}

ssize_t MemWrite(struct file *filp, const char *buf, 
                                    size_t count, loff_t *offset) {
    dbuf_t *mem;
    printk(KERN_ALERT "we are in the WRITE");
    mem = filp->private_data;
    kfree(mem->buffer);
    mem->buffer = (void *)kmalloc(count, GFP_KERNEL);
    if (mem->buffer == NULL) {
        printk(KERN_ALERT " could not allocate kernel memory\n");
        return(-ENOMEM);
    }
    mem->length = count;
    if (copy_from_user(mem->buffer, buf, count) != 0)
        count = -1;
    return(count);
}

ssize_t MemWriteInUppercase(struct file *filep, const char *buf, size_t count, loff_t *offset) {
    char *upperBuf = (char*)buf;
    int i;
    for(i = 0; i < count; i++){
        if ((*(upperBuf+i) > 'a') && (*(upperBuf+i) < 'z')){
            *(upperBuf+i) = (*(upperBuf+i) - 'a' + 'A');
        }
    }

    return MemWrite(filep, buf, count, offset);
}

/**************************************************************************/
````

````
root@securitylab-ubuntu:/home/user/Desktop/Treiber/aufgabe1# make
make -C /lib/modules/4.15.0-54-generic/build M=/home/user/Desktop/Treiber/aufgabe1 modules
make[1]: Entering directory '/usr/src/linux-headers-4.15.0-54-generic'
Makefile:976: "Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel"
  CC [M]  /home/user/Desktop/Treiber/aufgabe1/MemDriver.o
  Building modules, stage 2.
  MODPOST 1 modules
  CC      /home/user/Desktop/Treiber/aufgabe1/MemDriver.mod.o
  LD [M]  /home/user/Desktop/Treiber/aufgabe1/MemDriver.ko
make[1]: Leaving directory '/usr/src/linux-headers-4.15.0-54-generic'
root@securitylab-ubuntu:/home/user/Desktop/Treiber/aufgabe1# rmmod MemDriver
root@securitylab-ubuntu:/home/user/Desktop/Treiber/aufgabe1# insmod MemDriver.ko 
````

## Aufgabe 3

In dieser Aufgabe implementieren sie eine einfache Ampel-Steuerung. Dazu verwenden sie eine
Ampel, die am Parallel-Port angeschlossen werden kann: die rote, gelbe und gr ¨une LED lassen sich
einzeln ansteuern und der Zustand eines Tasters kann abgefragt werden.
F¨ ur die Ansteuerung der Ampel-Hardware m¨ussen sie einen einfachen Treiber (ParDriver.c) implementieren,
der ein Byte auf den Parallel-Port schreiben und ein Byte vom Port lesen kann.

````
root@securitylab-ubuntu:/home/user/Desktop/Treiber/aufgabe3/ParPortEmul# make
make -C /lib/modules/4.15.0-54-generic/build M=/home/user/Desktop/Treiber/aufgabe3/ParPortEmul modules
make[1]: Entering directory '/usr/src/linux-headers-4.15.0-54-generic'
Makefile:976: "Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel"
  CC [M]  /home/user/Desktop/Treiber/aufgabe3/ParPortEmul/ParPortEmul.o
  Building modules, stage 2.
  MODPOST 1 modules
  CC      /home/user/Desktop/Treiber/aufgabe3/ParPortEmul/ParPortEmul.mod.o
  LD [M]  /home/user/Desktop/Treiber/aufgabe3/ParPortEmul/ParPortEmul.ko
make[1]: Leaving directory '/usr/src/linux-headers-4.15.0-54-generic'

root@securitylab-ubuntu:/home/user/Desktop/Treiber/aufgabe3/ParPortDriver# make
cp ../ParPortEmul/Module.symvers .
make -C /lib/modules/4.15.0-54-generic/build M=/home/user/Desktop/Treiber/aufgabe3/ParPortDriver modules
make[1]: Entering directory '/usr/src/linux-headers-4.15.0-54-generic'
Makefile:976: "Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel"
  CC [M]  /home/user/Desktop/Treiber/aufgabe3/ParPortDriver/ParDriver.o
  Building modules, stage 2.
  MODPOST 1 modules
  CC      /home/user/Desktop/Treiber/aufgabe3/ParPortDriver/ParDriver.mod.o
  LD [M]  /home/user/Desktop/Treiber/aufgabe3/ParPortDriver/ParDriver.ko
make[1]: Leaving directory '/usr/src/linux-headers-4.15.0-54-generic'
````

**ParDriver.c**

````
/**************************************************************************
* Parport Device Driver
* 
* Author:		M. Thaler, A. Schmid
* File:			ParDriver.c
* Grundversion:	17.9.1999	A. Schmid
* Erweiterung, 
* Anpassungen:	25.11.2001	M. Thaler
*				27.08.2004	M. Thaler	-->> Kernel 2.6
*				- slab.h
*				- use_count: global variable
*				- include files adapated
*               18.02.2009  M. Thaler
*               - include "io.h" for par port emulation
*               20.01.2011  M. Thaler
*               - removed autoconf.h
*               23.05.20013 M. Thaler
*                - removed: <asm/system.h>, try_get_module() and module_put()
*               14.03.2016  M. Thaler
*                - printk(KERN_ALERT "..") to printk(KERN_ALERT "...)
*               05.05.2018  M. Thaler: new -> #include <linux/uaccess.h>
*               08.11.2018 M. Thaler 
*                - <asm/io.h> -> <linux/io.h>
* Version:      v.fs20
***************************************************************************/

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/fs.h>
#include <linux/uaccess.h>

//#include <linux/io.h>     // uncomment, when using with parallel port
#include "io.h" // comment to use with parallel port emulation

MODULE_LICENSE("GPL");

/*---------------------------------------------------------------------------*/
int use_count;
/*---------------------------------------------------------------------------*/

#define BASE_ADDR 0x378 /* IO base addr of lp1 */

#define MY_MAJOR 121 /* experimental MAJOR: 120 - 127*/

int ParOpen(struct inode *, struct file *);
int ParRelease(struct inode *, struct file *);
ssize_t ParRead(struct file *filp, char *buf, size_t count, loff_t *anything);
ssize_t ParWrite(struct file *filp, const char *buf,
                 size_t count, loff_t *anything);

/*---------------------------------------------------------------------------*/

/* using the tagged method -> portable */

struct file_operations ParFops = {
    .open = ParOpen,
    .release = ParRelease,
    .read = ParRead,
    .write = ParWrite,
};

/*---------------------------------------------------------------------------*/

int init_module(void)
{
  int res;
  printk(KERN_ALERT "Try to Register the Driver\n");
  use_count = 0;
  res = register_chrdev(MY_MAJOR, "ParDriver", &ParFops);
  if (res < 0)
    printk(KERN_ALERT "cannot register Driver");
  return (res);
}

void cleanup_module(void)
{
  printk(KERN_ALERT "Close Driver\n");
  unregister_chrdev(MY_MAJOR, "ParDriver");
}

/*---------------------------------------------------------------------------*/

int ParOpen(struct inode *inode, struct file *filp)
{
  printk(KERN_ALERT "we are in the OPEN\n");

  if (use_count != 0)
  {
    return (-EBUSY);
  }
  else
  {
    use_count++;
  }

  return (0);
}

int ParRelease(struct inode *inode, struct file *filp)
{
  printk(KERN_ALERT "we are in RELEASE\n");
  use_count--;
  return (0);
}

ssize_t ParRead(struct file *filp, char *buf, size_t count, loff_t *offset)
{
  char byte;
  printk(KERN_ALERT "we are in the READ\n");
  byte = inb(BASE_ADDR + 1);

  if (copy_to_user(buf, &byte, count) != 0)
  {
    count = -1;
  }

  return (count);
}

ssize_t ParWrite(struct file *filp, const char *buf, size_t count, loff_t *offset)
{
  char byte;
  printk(KERN_ALERT "we are in the WRITE");

  if (copy_from_user(&byte, buf, count) != 0)
  {
    count = -1;
  }

  outb(byte, BASE_ADDR);
  return (count);
}

/*****************************************************************************/
````

