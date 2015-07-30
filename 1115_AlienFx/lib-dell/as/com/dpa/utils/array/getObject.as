/**
 * Created with IntelliJ IDEA.
 * User: jerry.orta
 * Date: 2/27/13
 * Time: 5:10 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.array {

public function getObject(_array:Array,  queryName:String):Object {


    // Loop over earch objectin the 'haystack' that we wish to search.
    for each (var object : Object in _array)
    {
        if (object.name == queryName) {
            return object;
        }
    }

    return null;

}
}
