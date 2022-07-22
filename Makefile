SRC = main.cpp Stats/Stats.cpp Rectangle/Rectangle.cpp AudioPlayer/AudioPlayer.cpp Player/Player.cpp Tile/Tile.cpp func.cpp
DFLAGS	?= -pedantic -Wall -W -Wextra
LFLAGS 	?= -lSDL2 -lSDL2_mixer -lSDL2_image
FLAGS	?= $(DFLAGS) $(LFLAGS) -std=c++20
OBJ = $(addprefix bin/,$(subst .cpp,.o,$(notdir $(SRC))))
EXEC = Game
all: $(EXEC)

$(EXEC): $(OBJ)
	g++ -o $@ $^ $(FLAGS)

bin/%.o: src/*/%.cpp | bin
	g++ -c -o $@ $< $(FLAGS)

bin/main.o: src/main.cpp | bin
	g++ -c -o $@ $< $(FLAGS)
bin/func.o: src/func.cpp | bin
	g++ -c -o $@ $< $(FLAGS)
bin:
	-mkdir bin

clear:
	rm -rf bin/* $(EXEC) output/*

WEB_SRC	?= $(addprefix src/, $(SRC))
#WEB_SRC	?= src/main.cpp  src/Rectangle/Rectangle.cpp src/vec2d/vec2d.cpp src/movevec2d/movevec2d.cpp
web:
	em++ $(WEB_SRC) -I include -O2  -s USE_SDL=2 -s LLD_REPORT_UNDEFINED -o index.html -s USE_SDL_MIXER=2 -s USE_SDL_IMAGE=2 -s SDL2_IMAGE_FORMATS='["png"]' -s USE_OGG=1 --preload-file resources 
