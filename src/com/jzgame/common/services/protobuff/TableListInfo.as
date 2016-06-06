package com.jzgame.common.services.protobuff {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class TableListInfo extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.TableListInfo.ID", "iD", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var iD:int;

		/**
		 *  @private
		 */
		public static const TABLENAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.jzgame.common.services.protobuff.TableListInfo.tableName", "tableName", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var tableName:String;

		/**
		 *  @private
		 */
		public static const BLINDS:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.TableListInfo.blinds", "blinds", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		public var blinds:int;

		/**
		 *  @private
		 */
		public static const MINBUY:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.TableListInfo.minBuy", "minBuy", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		public var minBuy:int;

		/**
		 *  @private
		 */
		public static const MAXBUY:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.TableListInfo.maxBuy", "maxBuy", (5 << 3) | com.netease.protobuf.WireType.VARINT);

		public var maxBuy:int;

		/**
		 *  @private
		 */
		public static const MAXROLE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.TableListInfo.maxRole", "maxRole", (6 << 3) | com.netease.protobuf.WireType.VARINT);

		public var maxRole:int;

		/**
		 *  @private
		 */
		public static const ONLINE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.TableListInfo.online", "online", (7 << 3) | com.netease.protobuf.WireType.VARINT);

		public var online:int;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.iD);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.tableName);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.blinds);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.minBuy);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.maxBuy);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 6);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.maxRole);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 7);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.online);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var ID$count:uint = 0;
			var tableName$count:uint = 0;
			var blinds$count:uint = 0;
			var minBuy$count:uint = 0;
			var maxBuy$count:uint = 0;
			var maxRole$count:uint = 0;
			var online$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (ID$count != 0) {
						throw new flash.errors.IOError('Bad data format: TableListInfo.iD cannot be set twice.');
					}
					++ID$count;
					this.iD = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (tableName$count != 0) {
						throw new flash.errors.IOError('Bad data format: TableListInfo.tableName cannot be set twice.');
					}
					++tableName$count;
					this.tableName = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 3:
					if (blinds$count != 0) {
						throw new flash.errors.IOError('Bad data format: TableListInfo.blinds cannot be set twice.');
					}
					++blinds$count;
					this.blinds = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 4:
					if (minBuy$count != 0) {
						throw new flash.errors.IOError('Bad data format: TableListInfo.minBuy cannot be set twice.');
					}
					++minBuy$count;
					this.minBuy = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 5:
					if (maxBuy$count != 0) {
						throw new flash.errors.IOError('Bad data format: TableListInfo.maxBuy cannot be set twice.');
					}
					++maxBuy$count;
					this.maxBuy = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 6:
					if (maxRole$count != 0) {
						throw new flash.errors.IOError('Bad data format: TableListInfo.maxRole cannot be set twice.');
					}
					++maxRole$count;
					this.maxRole = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 7:
					if (online$count != 0) {
						throw new flash.errors.IOError('Bad data format: TableListInfo.online cannot be set twice.');
					}
					++online$count;
					this.online = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
