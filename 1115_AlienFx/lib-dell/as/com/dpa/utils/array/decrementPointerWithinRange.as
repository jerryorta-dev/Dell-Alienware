/**
 * Created with IntelliJ IDEA.
 * User: jerryorta
 * Date: 3/24/13
 * Time: 12:48 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.array {
    import utils.number.isBetween;

    public function decrementPointerWithinRange(val:int, min:int, max:int):int {
        val = (max + 1) - (min - val);
        if (isBetween(val, min,  max)) {
            return val;
        } else {
            return decrementPointerWithinRange(val, min, max);
        }
    }
}
