SC_VERSION=3.4.0
#BC_VERSION=v1.9.4-alpha
BC_VERSION=master
BC_REPO=dbroeglin/BlocklyCraft
MC_VERSION=1.14.3

recurse: out
	make -C out -f ../Makefile run

clean:
	rm -rf out

run: spigot-${MC_VERSION}.jar plugins/blocklycraft-${BC_VERSION}.jar eula.txt 
	java -jar $<

eula.txt:
	echo eula=true > $@

plugins/scriptcraft-%.jar: plugins
	rm -f plugins/scriptcraft*
	curl -L -o plugins/scriptcraft-$*.jar https://github.com/walterhiggins/ScriptCraft/releases/download/$*/scriptcraft.jar

BlocklyCraft-%:
	git clone --branch $* https://github.com/${BC_REPO}.git $@

BlocklyCraft-%/target/blocklycraft.jar: BlocklyCraft-%
	cd $<; ant

plugins/blocklycraft-%.jar: plugins BlocklyCraft-%/target/blocklycraft.jar
	rm -f plugins/blocklycraft*
	cp BlocklyCraft-$*/target/blocklycraft.jar $@
	#curl -L -o plugins/blocklycraft-$*.jar https://github.com/bgon/BlocklyCraft/releases/download/$*/blocklycraft.jar

out:
	mkdir out

plugins:
	mkdir plugins

spigot-%.jar: BuildTools.jar
	java -jar BuildTools.jar --rev $*

BuildTools.jar:
	curl -o $@ https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
