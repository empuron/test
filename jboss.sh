#!/usr/bin/env bats

@test "'jboss' Ordner in /opt vorhanden" {
  run stat /opt/jboss
  [ "$status" = 0 ]
}
