#!/usr/bin/env bats

@test "Java von Oracle" {
	run java -version
	[[ ${lines[0]} =~ "java version" ]]
}

@test "Java 7 installiert" {
  run java -version
  [[ ${lines[0]} =~ "1.7" ]]
}

@test "Postgres 9.2 vorhanden" {
	run psql --version
	[[ ${lines[0]} =~ "9.2" ]]
}
