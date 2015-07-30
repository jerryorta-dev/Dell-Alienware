/**
 * Created with IntelliJ IDEA.
 * User: jerryorta
 * Date: 3/24/13
 * Time: 12:09 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.array {
    public function checkRandomIntEqualToCurrentPointerPosition(random:int, current:int):int {
        if (random >= current) {
            return random + 1;
        } else {
            return random;
        }
    }

}
