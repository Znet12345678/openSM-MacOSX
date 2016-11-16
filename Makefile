CC = gcc
AR = ar
OBJS = obj/libio.o obj/libmisc.o obj/libclient.o obj/libuser.o
LDFLAGS =  -L${PWD} -rpath ${PWD}
CFLAGS = -Werror -Iinclude -O2 -g -fPIC -std=c99
PREFIX=/usr/local
all:
	@echo "CC libio.o"
	@${CC} -c lib/libio.c -o obj/libio.o ${CFLAGS}
	@echo "CC libmisc.o"
	@${CC} -c lib/libmisc.c -o obj/libmisc.o ${CFLAGS}
	@echo "CC libclient.o"
	@${CC} -c lib/libclient.c -o obj/libclient.o ${CFLAGS}
	@echo "CC libuser.o"
	@${CC} -c lib/libuser.c -o obj/libuser.o ${CFLAGS}
	@echo "AR libsm.a"
	@${AR} rcs libsm.a ${OBJS}
#Dynamic Libraries aren't yet supported
#	@echo "LDCC libsm.dylib"
#	@${CC} -o libsm.dylib ${OBJS} -shared ${LDFLAGS} ${CFLAGS} -install_path ${PWD}/libsm.dylib
	@echo "LDCC server.proto"
	@${CC}  server/server.c -o server/server.proto ${CFLAGS}
	@echo "LDCC client.proto"
	@${CC} client/client.mac.c -o client/client.proto ${CFLAGS} ${LDFLAGS} -lsm
	@echo "LDCC tools_dDat"
	@${CC} ${OBJS} src/tools_dDat.c -o tools_dDat ${LDFLAGS} ${CFLAGS}
	@echo "LDCC tools_wfDat"
	@${CC} ${OBJS} src/tools_wfDat.c -o tools_wfDat ${LDFLAGS} ${CFLAGS}
	@echo "LDCC tools_dfDat"
	@${CC} ${OBJS} src/tools_dfDat.c -o tools_dfDat ${LDFLAGS} ${CFLAGS}
	@echo "LDCC tools_wDat"
	@${CC} ${OBJS} src/tools_wDat.c -o tools_wDat ${LDFLAGS} ${CFLAGS}
	@echo "LDCC dev_dump_fDat"
	@${CC} ${OBJS} src/dump_fDat.c -o dev_dump_fDat ${LDFLAGS} ${CFLAGS}
	@echo "LDCC dev_send_txt"
	@${CC} ${OBJS} src/dev_send_txt.mac.c -o dev_send_txt ${LDFLAGS} ${CFLAGS}
	@echo "LDCC client_txt_generic"
	@${CC} ${LDFLAGS} ${CFLAGS} -o client_txt_generic src/client_txt_generic.c -lsm
	@echo "TEST tests"
	@make -C tests tests
install:
	@echo "INSTALL libsm.so"
	@install libsm.so ${PREFIX}/lib
	@echo "INSTALL libsm.a"
	@install libsm.a ${PREFIX}/lib
clean:
	@echo "CLEAN"
	@rm -f obj/*.o dev_send_txt dev_dump_fDat tools_wDat libsm.a libsm.so client_txt_generic tools_dfDat tools_wfDat tools_dDat libsm.a libsm.so libsm.so.1 server/server.proto client/client.proto tests/opensm-libio-test-txt tests/opensm-libio-test-file
