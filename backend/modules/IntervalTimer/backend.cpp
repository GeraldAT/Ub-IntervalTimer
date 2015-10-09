/**
  * Interval Timer is a program to configure custom timers for interval trainings and workouts
  * Copyright (c) 2015 Gerald Ortner <ortner.g@hotmail.com>
  *
  * This file is part of Interval Timer
  *
  * Interval Timer is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 3 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program. If not, see <http://www.gnu.org/licenses/>.
  *
  */

#include <QtQml>
#include <QtQml/QQmlContext>
#include "backend.h"
#include "mytype.h"


void BackendPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QLatin1String("IntervalTimer"));

    qmlRegisterType<MyType>(uri, 1, 0, "MyType");
}

void BackendPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    QQmlExtensionPlugin::initializeEngine(engine, uri);
}

