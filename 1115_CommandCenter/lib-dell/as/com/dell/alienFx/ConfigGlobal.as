/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/8/13
 * Time: 4:13 AM
 *
 */
package com.dell.alienFx {
public class ConfigGlobal {

    public static var CTA:Object = {};
    public static const CTA_TextField_XPOS:Number = 16;
    public static const CTA_TextField_YPOS:Number = 0;
    public static const CTA_ICON_YPOS:Number = 3;
    public static const CTA_ICON_MARGIN_LEFT:Number = 12;

    public static const ALIENFX_NUMBER_BLUR:Number = .5;
    public static const ALIENFX_STRENGTH:Number = 5;
    public static const ALIENFX_QUALITY:Number = 2;

public static function getCTA():Object {

    ConfigGlobal.CTA = {
        width:107,
        height:20,
        radiusRect:18,
        fillColor:SwatchAFX.LINK_TEAL};

    return ConfigGlobal.CTA;
}
}
}
