/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 6/3/13
 * Time: 5:59 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.math {

import com.dpa.utils.math.ScaleMode;

import flash.display.DisplayObject;

import flash.geom.Matrix;
import flash.geom.Rectangle;

public class Dimensions {
    private var vars:Object;




    private var _width:Number;
    private var _height:Number;
    private var _depth:Number;

    private var _targetMaxWidth:Number;
    private var _targetMaxHeight:Number;
    private var _targetMaxDepth:Number;

    private var _targetMinWidth:Number;
    private var _targetMinHeight:Number;
    private var _targetMinDepth:Number;

    private var _scaledWidth:Number;
    private var _scaledHeight:Number;
    private var _scaledDepth:Number;

    private var _rawTargetWidth:Number;
    private var _rawTargetHeight:Number;
    private var _rawTargetDepth:Number;

    private var _scaleMode:String;


    public function Dimensions(vars:Object = null) {
        this.vars = (vars != null) ? vars : {};

        _scaleMode = (this.vars.scaleMode != null) ? this.vars.scaleMode : ScaleMode.PROPORTIONAL_INSIDE;

        _width = (this.vars.width != null) ? this.vars.width : 1;
        _height = (this.vars.height != null) ? this.vars.height : 1;
        _depth = (this.vars.depth != null) ? this.vars.depth : 1;

        _rawTargetWidth = _targetMaxWidth = (this.vars.maxWidth != null) ? this.vars.maxWidth : 1;
        _rawTargetHeight = _targetMaxHeight = (this.vars.maxHeight != null) ? this.vars.maxHeight : 1;
        _rawTargetDepth = _targetMaxDepth = (this.vars.maxDepth != null) ? this.vars.maxDepth : 1;

        _targetMinWidth = (this.vars.minWidth != null) ? this.vars.minWidth : 1;
        _targetMinHeight = (this.vars.minHeight != null) ? this.vars.minHeight : 1;
        _targetMinDepth = (this.vars.minDepth != null) ? this.vars.minDepth : 1;

        calculate();
    }

    private function calculate():void {
        if (_scaleMode == ScaleMode.PROPORTIONAL_INSIDE) {
            calculateProportionInside();
        }
    }

    private function calculateProportionInside():void {
        var oRatio:Number = _width / _height;
        var tRatio:Number = _rawTargetWidth / _rawTargetHeight;

        if (oRatio < tRatio) {
            _scaledWidth = _targetMaxHeight / tRatio;
            if (_scaledWidth == 0) {
                _scaledHeight = 0;
            } else if (_scaledWidth > _targetMaxWidth) {
                _scaledWidth = _targetMaxWidth;
                _scaledHeight = _scaledWidth / tRatio;
            } else if (_scaledWidth < _targetMinWidth) {
                _scaledWidth = _targetMinWidth;
                _scaledHeight = _scaledWidth / tRatio;
            }
        }

        if (oRatio > tRatio) {
            _scaledHeight = _targetMaxWidth / tRatio;
            if (_scaledHeight > _targetMaxHeight) {
                _scaledHeight = _targetMaxHeight;
                _scaledWidth = _scaledHeight * tRatio;
            } else if (_scaledHeight < _targetMinHeight) {
                _scaledHeight = _targetMinHeight;
                _scaledWidth = _scaledHeight * tRatio;
            }
        }


    }

    public function get scaledHeight():Number {
        return _scaledHeight;
    }

    public function get scaledWidth():Number {
        return _scaledWidth;
    }


    public function get targetMaxHeight():Number {
        return _targetMaxHeight;
    }

    public function set targetMaxHeight(value:Number):void {
        _targetMaxHeight = value;
        calculate();
    }

    public function get targetMaxWidth():Number {
        return _targetMaxWidth;
    }

    public function set targetMaxWidth(value:Number):void {
        _targetMaxWidth = value;
        calculate();
    }
}
}
