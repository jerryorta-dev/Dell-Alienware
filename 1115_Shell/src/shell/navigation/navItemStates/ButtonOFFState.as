﻿package shell.navigation.navItemStates{import com.dell.alienFx.GlobalAnim;import com.greensock.TweenLite;import com.greensock.plugins.TintPlugin;import com.greensock.plugins.TweenPlugin;import shell.configs.ConfigShell;import flash.display.Sprite;import shell.navigation.navItemStates.abstract.Context_NavItem_States;import shell.navigation.navItemStates.abstract.IState_ButtonONOFF;import shell.navigation.navTabItemFactoryPattern.CreateNavItem;import shell.navigation.navTabItemFactoryPattern.creators.CreateNavShapeItem;//Stop State;	public class ButtonOFFState implements IState_ButtonONOFF	{        private var buttons:Context_NavItem_States;        private var target:CreateNavItem;		public function ButtonOFFState(_buttons:Context_NavItem_States, _target:CreateNavItem)		{            TweenPlugin.activate([TintPlugin]);//			trace("----");			this.buttons=_buttons;            this.target = _target;		}		public function ON():void		{//            trace("toggle ON from ButtonOFFState")            TweenLite.to(this.target, GlobalAnim.TRANSISITION, {matrixTx:  -110});            TweenLite.to(this.target, GlobalAnim.TRANSISITION, {pointX: 112});            TweenLite.to(this.target, GlobalAnim.TRANSISITION, {hoverAlpha:0});            TweenLite.to(this.target.iconGraphic, GlobalAnim.TRANSISITION, {alpha:1});            buttons.setState( buttons.getOnButtonState() );        }        public function OFF():void        {//            trace("toggle OFF from ButtonOFFState")//            trace("Your button is already OFF");		}        public function OVER():void {//            trace("toggle OVER from ButtonOFFState")            TweenLite.to(this.target, GlobalAnim.TRANSISITION, {hoverAlpha: 1});            buttons.setState( buttons.getOverButtonState() );        }	}}