/* Copyright (c) 2016 
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
 * @requires 
 * @requires core/extend.js  
*/

/* constructor
@param string id
@param object options{

}
*/
function GridColumnCustomTime(id,options){
	options = options || {};	
	
	GridColumnCustomTime.superclass.constructor.call(this,id,options);
}
extend(GridColumnCustomTime,GridColumn);

/* Constants */

/* private members */

/* protected*/


/* public methods */
GridColumnCustomTime.prototype.formatVal = function(v){
	var days = 0,hours = 0,minutes = 0;
	var p = v.indexOf(":");
	if (p>=0){
		hours = parseInt(v.substring(0,p));
		minutes = parseInt(v.substring(p+1));
		if (hours>24){
			days = Math.floor(hours/24);
			hours = (hours % 24);
		}
	}
	else{
		minutes = v;
	}
	
	var res = (days>0)? days+" сут.":"";
	if (hours>0){
		res += (res=="")? "":" ";
		res +=  hours+" ч.";
	}
	if (minutes>0){
		res += (res=="")? "":" ";
		res +=  minutes+" мин.";
	}
	
	return res;
}
