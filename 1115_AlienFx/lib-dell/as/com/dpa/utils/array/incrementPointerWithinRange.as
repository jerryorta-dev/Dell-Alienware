/**
 * Created with IntelliJ IDEA.
 * User: jerryorta
 * Date: 3/24/13
 * Time: 12:46 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.array {
    import utils.number.isBetween;

    public function incrementPointerWithinRange(val:int, min:int, max:int):int
    {
        val = (val - (max + 1)) + min;
        if (isBetween(val, min,  max)) {
            return val;
        } else {
            return incrementPointerWithinRange(val, min, max);
        }
    }

}
