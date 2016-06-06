package com.jzgame.common.services.protobuff {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.jzgame.common.services.protobuff.TournamentType;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class JoinTournamentRequest extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const UID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.JoinTournamentRequest.uid", "uid", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var uid:int;

		/**
		 *  @private
		 */
		public static const TOKEN:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.jzgame.common.services.protobuff.JoinTournamentRequest.token", "token", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var token:String;

		/**
		 *  @private
		 */
		public static const TYPE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.jzgame.common.services.protobuff.JoinTournamentRequest.type", "type", (3 << 3) | com.netease.protobuf.WireType.VARINT, com.jzgame.common.services.protobuff.TournamentType);

		public var type:int;

		/**
		 *  @private
		 */
		public static const ISOBSERVER:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.jzgame.common.services.protobuff.JoinTournamentRequest.isobserver", "isobserver", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		public var isobserver:Boolean = false;

		/**
		 *  @private
		 */
		public static const TARGETID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.JoinTournamentRequest.targetid", "targetid", (5 << 3) | com.netease.protobuf.WireType.VARINT);

		private var targetid$field:int;

		private var hasField$0:uint = 0;

		public function clearTargetid():void {
			hasField$0 &= 0xfffffffe;
			targetid$field = new int();
		}

		public function get hasTargetid():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set targetid(value:int):void {
			hasField$0 |= 0x1;
			targetid$field = value;
		}

		public function get targetid():int {
			return targetid$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.uid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.token);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
			com.netease.protobuf.WriteUtils.write$TYPE_ENUM(output, this.type);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
			com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, this.isobserver);
			if (hasTargetid) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, targetid$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var uid$count:uint = 0;
			var token$count:uint = 0;
			var type$count:uint = 0;
			var isobserver$count:uint = 0;
			var targetid$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (uid$count != 0) {
						throw new flash.errors.IOError('Bad data format: JoinTournamentRequest.uid cannot be set twice.');
					}
					++uid$count;
					this.uid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (token$count != 0) {
						throw new flash.errors.IOError('Bad data format: JoinTournamentRequest.token cannot be set twice.');
					}
					++token$count;
					this.token = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 3:
					if (type$count != 0) {
						throw new flash.errors.IOError('Bad data format: JoinTournamentRequest.type cannot be set twice.');
					}
					++type$count;
					this.type = com.netease.protobuf.ReadUtils.read$TYPE_ENUM(input);
					break;
				case 4:
					if (isobserver$count != 0) {
						throw new flash.errors.IOError('Bad data format: JoinTournamentRequest.isobserver cannot be set twice.');
					}
					++isobserver$count;
					this.isobserver = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				case 5:
					if (targetid$count != 0) {
						throw new flash.errors.IOError('Bad data format: JoinTournamentRequest.targetid cannot be set twice.');
					}
					++targetid$count;
					this.targetid = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
