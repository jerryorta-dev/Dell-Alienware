/**
 * Created with IntelliJ IDEA.
 * User: jerryorta
 * Date: 12/10/12
 * Time: 2:44 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.regexp {

    /**
     * Most common characters used for English.
     * @return
     */
    public function createValidCharactersRegExp_Default_English():RegExp {
        var pattern:RegExp = /[0-9a-zA-Z!@#$%^&*\(\)_+-=\{\}\|\[\];:'",.\/<>? ]/gixsm;
        return pattern;
    }
}
