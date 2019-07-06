SC_VERSION=3.4.0
MC_VERSION=1.14.3

recurse: out
	make -C out -f ../Makefile run

clean:
	rm -rf out

run: spigot-${MC_VERSION}.jar plugins/scriptcraft-${SC_VERSION}.jar eula.txt 
	java -jar $<

eula.txt:
	echo eula=true > $@

plugins/scriptcraft-%.jar: plugins
	curl -o plugins/scriptcraft-$*.jar https://github.com/walterhiggins/ScriptCraft/releases/download/$*/scriptcraft.jar

out:
	mkdir out

plugins:
	mkdir plugins

spigot-%.jar: BuildTools.jar
	java -jar BuildTools.jar --rev $*

BuildTools.jar:
	curl -o $@ https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
