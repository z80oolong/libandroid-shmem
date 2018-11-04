CC = gcc
STRIP = strip

LIBANDROID_SHMEM_SO = libandroid-shmem.so
TYPE = debian-noroot

CFLAGS += -fPIC -shared -std=gnu99 -Wall -Wextra -Wl,--version-script=exports.txt
LDFLAGS +=

ifeq ($(TYPE), debian-noroot)
LIBANDROID_SHMEM_SO = libandroid-shmem-termux.so
CFLAGS += -DDEBIAN_NOROOT
LDFLAGS += -lc -lpthread
else
LIBANDROID_SHMEM_SO = libandroid-shmem.so
LDFLAGS += -llog
endif

$(LIBANDROID_SHMEM_SO): shmem.c shm.h
	$(CC) $(CFLAGS) $(LDFLAGS) shmem.c -o $@
	$(STRIP) $@

install: $(LIBANDROID_SHMEM_SO) shm.h
	install -D $(LIBANDROID_SHMEM_SO) $(PREFIX)/lib/$(LIBANDROID_SHMEM_SO)
	install -D shm.h $(PREFIX)/include/sys/shm.h

clean:
	rm -f libandroid-shmem.so libandroid-shmem-termux.so

.PHONY: install
