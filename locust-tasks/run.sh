#!/bin/bash

# Copyright 2015 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


LOCUST="/usr/local/bin/locust"
LOCUS_OPTS="--locustfile=locust-tasks/$LOCUST_FILE $LOCUSTS --host=$TARGET_HOST --web-auth $USERNAME:$PASSWORD"
LOCUST_MODE=${LOCUST_MODE:-standalone}

if [[ "$LOCUST_MODE" = "master" ]]; then
    export LOCUST_MASTER_PORT=8089
    echo "$LOCUST_MASTER_PORT"
    LOCUS_OPTS="$LOCUS_OPTS --master --web-port 8080"

    if [[ "$STEP_MODE" = true ]]; then
      LOCUS_OPTS="$LOCUS_OPTS --step-load"
    fi
elif [[ "$LOCUST_MODE" = "worker" ]]; then
    LOCUS_OPTS="$LOCUS_OPTS --slave --master-host=$PERF_MASTER --master-port=5557"
fi

echo "$LOCUST $LOCUS_OPTS"

$LOCUST $LOCUS_OPTS
