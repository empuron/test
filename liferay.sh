#!/usr/bin/env bats

@test "'liferay' Ordner in /opt vorhanden" {
	run stat /opt/liferay
	[ "$status" = 0 ]
}

@test "Liferay 'backups' Ordner vorhanden" {
	skip "Noch nicht relevant"
	run stat /opt/liferay/backups
	[ "$status" = 0 ]
}
