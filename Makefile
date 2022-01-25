CXX             ?= g++
CXXFLAGS        ?= -Werror -Wall -Wmissing-declarations -Wpointer-arith \
					 -Wwrite-strings -Wcast-qual -Wcast-align -Wformat-security \
					 -Wformat-nonliteral -Wmissing-format-attribute -Winline \
					 -pedantic-errors -fstack-protector-all -D_FORTIFY_SOURCE=2 \
					 -fPIC -std=c++11 -pthread

LMCP_DIR        ?= ./lmcp
STANAG4586_DIR  ?= ./stanag4586

GENERICAPI_DIR   = $(LMCP_DIR)/pkg_deps/genericapi
TRANSPORTS_DIR   = $(GENERICAPI_DIR)/pkg_deps/transports-cpp

INCLUDES         = -I$(GENERICAPI_DIR)/include -I$(TRANSPORTS_DIR)/include/base \
				   -I$(TRANSPORTS_DIR)/include/zmq \
				   -I$(GENERICAPI_DIR)/serializers/include \
				   -I$(GENERICAPI_DIR)/serializers/serializer_lmcp/include \
				   -I$(GENERICAPI_DIR)/serializers/serializer_stanag4586/include \
				   -I$(LMCP_DIR)/include -I$(STANAG4586_DIR)/include

LIBPATHS         = -L$(TRANSPORTS_DIR)/build/libs/ZeroMQ

LIBS             = -lTangramTransportZMQ \
				   $(GENERICAPI_DIR)/serializers/serializer_lmcp/build/libs/libtangramlmcpserializer.a \
				   $(GENERICAPI_DIR)/serializers/serializer_stanag4586/build/libs/libtangramstanag4586serializer.a \
				   $(LMCP_DIR)/build/libs/libtangramgeneric.a \
				   $(STANAG4586_DIR)/build/libs/libtangramgeneric.a \
				   $(GENERICAPI_DIR)/build/libs/libtangramgenericapi.a

all: receiver

receiver: receiver.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -o receiver receiver.cpp $(LIBPATHS) $(LIBS)

clean:
	@rm receiver
