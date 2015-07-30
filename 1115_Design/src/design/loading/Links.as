/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/1/13
 * Time: 11:13 AM
 *
 */
package design.loading {

import com.dell.services.PathManager;
import flash.display.LoaderInfo;

public class Links {

    public static const CONFIG:String = "design-config.xml";

    public static function init(_li:LoaderInfo):void {
        PathManager.init( _li );
    }

    public static function getLocalizedXML():String {
        return PathManager.getLocalizedXML();
    }

    public static function getFullPathByFileExtension(_fileName:String, _type:String = null):String {
        return PathManager.getFullPathByFileExtension(_fileName, _type);
    }
}


}
