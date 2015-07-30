/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 6/2/13
 * Time: 11:17 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.motion {

    public function rateOfSpeed(_value1:Number, _value2:Number, _speed:Number):Number {
        return Math.abs(_value1 - _value2) /_speed;
    }

}
