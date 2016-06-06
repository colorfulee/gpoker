package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.common.vo.TaskConfigVO;
	import com.jzgame.common.vo.TaskVO;
	import com.jzgame.util.ItemStringUtil;
	
	import flash.utils.Dictionary;

	public class TaskConfig implements IConfigHelper
	{
		/*auther     :jim
		* file       :TaskConfigModel.as
		* date       :Dec 9, 2014
		* description:
		*/
		private var _dic:Dictionary = new Dictionary;
		private var _list:Array = [];
		public function TaskConfig()
		{
		}
		
		/**
		 * 
		 * @param xml
		 * 
		 */
		public function setData(xml:XML):void
		{
			var cvo:TaskConfigVO;
			for(var j:String in xml.base)
			{
				cvo = new TaskConfigVO;
				cvo.id = String(xml.base[j].id);
				cvo.level = String(xml.base[j].level);
				cvo.bonus = String(xml.base[j].bonus);
				cvo.desc = String(xml.base[j].desc);
				cvo.name = String(xml.base[j].name);
				cvo.title = String(xml.base[j].title);
				cvo.point = String(xml.base[j].point);
				cvo.type = String(xml.base[j].type);
				cvo.limited = uint(xml.base[j].limited);
				cvo.start_time = Number(xml.base[j].start_time);
				cvo.end_time = Number(xml.base[j].end_time);
				cvo.task_desc = String(xml.base[j].task_desc);
				cvo.img = String(xml.base[j].img);
				_dic[uint(xml.base[j].id)] = cvo;
			}
		}
		public function setDataVO(value:Object):void
		{
			setJsonData(value);
		}
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function setJsonData(value:Object):void
		{
			var cvo:TaskConfigVO;
			var taskStateVO:TaskVO;
			for(var j:String in value)
			{
				cvo = new TaskConfigVO;
				cvo.id = String(value[j].id);
				cvo.level = String(value[j].level);
				cvo.bonus = ItemStringUtil.getBonusString(value[j].bonus);
//				var arr:Array = [];
//				for(var m:String in value[j].bonus)
//				{
//					arr.push(m+":"+value[j].bonus[m]);
//				}
//				cvo.bonus= arr.join(",");
//				cvo.bonus = String(value[j].bonus);
				cvo.desc = String(value[j].desc);
				cvo.name = String(value[j].name);
				cvo.title = String(value[j].title);
				cvo.point = String(value[j].point);
				cvo.type = String(value[j].type);
				cvo.start_time = Number(value[j].start_time);
				cvo.end_time = Number(value[j].end_time);
				cvo.limited = uint(value[j].limited);
				cvo.task_desc = String(value[j].task_desc);
				cvo.img = String(value[j].img);
				
				taskStateVO = new TaskVO;
				taskStateVO.id = cvo.id;
				taskStateVO.taskConfigVO = cvo;
				_dic[uint(value[j].id)] = taskStateVO;
				_list.push(taskStateVO);
			}
		}
		/**
		 * 获取任务列表 
		 * @return 
		 * 
		 */		
		public function getAllTask():Array
		{
			return _list.concat();
		}
		/**
		 * 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getTaskById(id:String):TaskVO
		{
			return _dic[id];
		}
	}
}