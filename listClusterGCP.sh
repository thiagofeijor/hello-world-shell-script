#!/bin/bash

create_cluster()
{
  myPi=$(gcloud container clusters list)

  echo $myPi
}

create_cluster