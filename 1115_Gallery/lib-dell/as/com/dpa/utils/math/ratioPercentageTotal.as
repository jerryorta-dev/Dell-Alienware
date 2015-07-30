/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/8/13
 * Time: 8:43 AM
 *
 */
package com.dpa.utils.math {

/**
 * Percent is a  number from 0 to 1
 *
 * var p:Number = ratioPercentageTotal(.5, 2, 255);
 * //p =
 *
 * @param targetPercent
 * @param maxPercent
 * @param ratioOf
 * @return
 */
    public function ratioPercentageTotal(targetPercent:Number, maxPercent, ratioOf:Number):Number {

        return (ratioOf / maxPercent) * targetPercent;
    }

}
