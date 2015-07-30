/**
 * Created with IntelliJ IDEA.
 * User: jerry.orta
 * Date: 2/27/13
 * Time: 5:10 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.array {
import flash.utils.Dictionary;

public function getObjectsArray(_array:Array,  searchQueryMap:Dictionary):Array {

    var results : Array = [];

    // Loop over earch objectin the 'haystack' that we wish to search.
    for each (var object : Object in _array)
    {
        // This variable is used to break out of the loop if the current object doesn't match the
        // searchQueryMap; this gets reset to true for each loop of the supplied array.
        var match : Boolean = true;

        // Loop over each key (property) in the searchQueryMap.
        for (var key : * in searchQueryMap)
        {
            if (searchQueryMap[key] !== object[key])
            {
                // No match, we can break out of looping over the searchQueryMap here.
                match = false;
                break;
            }
        }

        // Check to see if we still have a positive match; if we do, push it onto the results Array.
        if (match) {
            results.push(object);
        }
    }

    return results;

}
}
