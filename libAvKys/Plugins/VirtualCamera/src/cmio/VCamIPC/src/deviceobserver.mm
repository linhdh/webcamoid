/* Webcamoid, webcam capture application.
 * Copyright (C) 2020  Gonzalo Exequiel Pedone
 *
 * Webcamoid is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Webcamoid is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Webcamoid. If not, see <http://www.gnu.org/licenses/>.
 *
 * Web-Site: http://webcamoid.github.io/
 */

#include <QWaitCondition>

#include "deviceobserver.h"

@implementation DeviceObserverVCamCMIO

- (id) initWithCaptureObject: (AkVCam::IpcBridge *) object
{
    self = [super init];

    if (!self)
        return nil;

    m_bridge = object;

    return self;
}

- (void) cameraConnected: (NSNotification *) notification
{
    Q_UNUSED(notification)

    if (!m_bridge)
        return;

    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       if (m_bridge)
                           m_bridge->cameraConnected();
                   });
}

- (void) cameraDisconnected: (NSNotification *) notification
{
    Q_UNUSED(notification)

    if (!m_bridge)
        return;

    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       if (m_bridge)
                           m_bridge->cameraDisconnected();
                   });
}

- (void) disconnect
{
    [NSObject cancelPreviousPerformRequestsWithTarget: self];
    m_bridge = NULL;
}

@end
