package com.jzgame.common.services.protobuff {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.jzgame.common.services.protobuff.TableCardInfo;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class TableRoleListInfo extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const LEVEL:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.TableRoleListInfo.level", "level", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var level:int;

		/**
		 *  @private
		 */
		public static const CHIP:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.TableRoleListInfo.chip", "chip", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		public var chip:int;

		/**
		 *  @private
		 */
		public static const STATE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.TableRoleListInfo.state", "state", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		public var state:int;

		/**
		 *  @private
		 */
		public static const TIMEPASS:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.TableRoleListInfo.timePass", "timePass", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		public var timePass:int;

		/**
		 *  @private
		 */
		public static const CARDINFO:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.jzgame.common.services.protobuff.TableRoleListInfo.cardInfo", "cardInfo", (5 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.jzgame.common.services.protobuff.TableCardInfo; });

		[ArrayElementType("com.jzgame.common.services.protobuff.TableCardInfo")]
		public var cardInfo:Array = [];

		/**
		 *  @private
		 */
		public static const ROLEID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.TableRoleListInfo.roleID", "roleID", (6 << 3) | com.netease.protobuf.WireType.VARINT);

		public var roleID:int;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.level);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.chip);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.state);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.timePass);
			for (var cardInfo$index:uint = 0; cardInfo$index < this.cardInfo.length; ++cardInfo$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.cardInfo[cardInfo$index]);
			}
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 6);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.roleID);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var level$count:uint = 0;
			var chip$count:uint = 0;
			var state$count:uint = 0;
			var timePass$count:uint = 0;
			var roleID$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (level$count != 0) {
						throw new flash.errors.IOError('Bad data format: TableRoleListInfo.level cannot be set twice.');
					}
					++level$count;
					this.level = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (chip$count != 0) {
						throw new flash.errors.IOError('Bad data format: TableRoleListInfo.chip cannot be set twice.');
					}
					++chip$count;
					this.chip = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 3:
					if (state$count != 0) {
						throw new flash.errors.IOError('Bad data format: TableRoleListInfo.state cannot be set twice.');
					}
					++state$count;
					this.state = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 4:
					if (timePass$count != 0) {
						throw new flash.errors.IOError('Bad data format: TableRoleListInfo.timePass cannot be set twice.');
					}
					++timePass$count;
					this.timePass = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 5:
					this.cardInfo.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.jzgame.common.services.protobuff.TableCardInfo()));
					break;
				case 6:
					if (roleID$count != 0) {
						throw new flash.errors.IOError('Bad data format: TableRoleListInfo.roleID cannot be set twice.');
					}
					++roleID$count;
					this.roleID = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
