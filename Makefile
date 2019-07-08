SC_VERSION=3.4.0
#BC_VERSION=v1.9.4-alpha
BC_VERSION=master
BC_REPO=dbroeglin/BlocklyCraft
MC_VERSION=1.14.3

all: game/spigot-${MC_VERSION}.jar game/plugins/blocklycraft-${BC_VERSION}.jar game/eula.txt game/server.properties

run: game/spigot-${MC_VERSION}.jar all
	cd $(<D); java -jar $(<F)

clean:
	rm -rf work
	rm -rf game/plugins
clean-blockly:
	rm -rf game/plugins/blockly*
clean-plugins:
	rm -rf game/plugins

game/server.properties: server.properties
	mkdir -p $(@D)
	cp $< $@

game/eula.txt:
	mkdir -p $(@D)
	echo eula=true > $@

game/spigot-%.jar: work/Spigot/spigot-%.jar
	mkdir -p $(@D)
	cp $< $@
game/plugins/blocklycraft-%.jar: work/BlocklyCraft-%-/target/blocklycraft.jar clean-blockly
	mkdir -p $(@D)
	cp $< $@
	#curl -L -o plugins/blocklycraft-$*.jar https://github.com/bgon/BlocklyCraft/releases/download/$*/blocklycraft.jar

work/BlocklyCraft-%-:
	git clone --branch $* https://github.com/${BC_REPO}.git $@

work/BlocklyCraft-%-/target/blocklycraft.jar: work/BlocklyCraft-%-
	cd $<; ant

work/Spigot/spigot-%.jar: work/BuildTools.jar
	mkdir -p $(@D)
	start=$$(pwd);cd $(@D); java -jar $$start/$< --rev $*

work/BuildTools.jar:
	mkdir -p $(@D)
	curl -o $@ https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
