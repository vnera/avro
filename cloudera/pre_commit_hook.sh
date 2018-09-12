#!/bin/bash
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

set -exu

CURRENT_BRANCH=cdh6.0.1
export CDH_GBN=$(curl "http://builddb.infra.cloudera.com:8080/resolvealias?alias=$CURRENT_BRANCH")

# Workaround to use proper mvn settings instead of wrong ~jenkins/.m2/settings.xml
mvn_settings="$(mktemp)"
trap "rm -f $mvn_settings" EXIT
curl http://github.mtv.cloudera.com/raw/CDH/cdh/${CURRENT_BRANCH}/gbn-m2-settings.xml > "$mvn_settings"

mvn -s "$mvn_settings" -P cdh-precommit clean test --fail-at-end

