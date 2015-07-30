/**
 * Created with IntelliJ IDEA.
 * User: jerry.orta
 * Date: 3/10/13
 * Time: 5:26 PM
 */
package com.dpa.utils.math {

/**
 * The *Base arguments must be between 2 and 36;
 *
 * TODO create conversion algorithm to include any base range
 *
 * @param value
 * @param fromBase
 * @param toBase
 * @return
 */
public function convertBaseToBase(value:String, fromBase:Number, toBase:Number):String {
    /*
    var toBase10:Number = parseInt(value, fromBase);
    var result:String = toBase10.toString(targetBase);

    return result;
    */

    return (parseInt(value, fromBase).toString(toBase));

}
}

