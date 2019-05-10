#!/bin/sh

# sj_simulator_ios_delete_unavailable.sh
# Copyright (C) 2019 Stefan Jager

#
# Deletes all iOS simulators that are not supported by the current Xcode SDK.
#
# Prerequisites:
# - Relies on xcrun and simctl to do the hard work.
#

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

xcrun simctl delete unavailable
