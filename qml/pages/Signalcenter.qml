import QtQuick 2.0
import Sailfish.Silica 1.0

QtObject{
         id:signalcenter;
         signal loadStarted;
         signal loadFinished;
         signal loadFailed(string errorstring);
         signal loginSucceed;
         signal loginFailed(string fail);
         function showMessage(msg)
                 {
                  if (msg||false)
                    {
                      console.log(msg);
                      addNotification(msg);
                    }
                 }
        }
