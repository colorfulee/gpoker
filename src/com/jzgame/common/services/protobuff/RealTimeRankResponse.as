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
	public dynamic final class RealTimeRankResponse extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const RANK:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.RealTimeRankResponse.rank", "rank", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var rank:int;

		/**
		 *  @private
		 */
		public static const TOTAL:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.jzgame.common.services.protobuff.RealTimeRankResponse.total", "total", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		public var total:int;

		/**
		 *  @private
		 */
		public static const CHIPS:FieldDescriptor$TYPE_INT64 = new FieldDescriptor$TYPE_INT64("com.jzgame.common.services.protobuff.RealTimeRankResponse.chips", "chips", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		public var chips:Int64;

		/**
		 *  @private
		 */
		public static const PRECHIPS:FieldDescriptor$TYPE_INT64 = new FieldDescriptor$TYPE_INT64("com.jzgame.common.services.protobuff.RealTimeRankResponse.prechips", "prechips", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		private var prechips$field:Int64;

		public function clearPrechips():void {
			prechips$field = null;
		}

		public function get hasPrechips():Boolean {
			return prechips$field != null;
		}

		public function set prechips(value:Int64):void {
			prechips$field = value;
		}

		public function get prechips():Int64 {
			return prechips$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.rank);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.total);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
			com.netease.protobuf.WriteUtils.write$TYPE_INT64(output, this.chips);
			if (hasPrechips) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_INT64(output, prechips$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var rank$count:uint = 0;
			var total$count:uint = 0;
			var chips$count:uint = 0;
			var prechips$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (rank$count != 0) {
						throw new flash.errors.IOError('Bad data format: RealTimeRankResponse.rank cannot be set twice.');
					}
					++rank$count;
					this.rank = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (total$count != 0) {
						throw new flash.errors.IOError('Bad data format: RealTimeRankResponse.total cannot be set twice.');
					}
					++total$count;
					this.total = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 3:
					if (chips$count != 0) {
						throw new flash.errors.IOError('Bad data format: RealTimeRankResponse.chips cannot be set twice.');
					}
					++chips$count;
					this.chips = com.netease.protobuf.ReadUtils.read$TYPE_INT64(input);
					break;
				case 4:
					if (prechips$count != 0) {
						throw new flash.errors.IOError('Bad data format: RealTimeRankResponse.prechips cannot be set twice.');
					}
					++prechips$count;
					this.prechips = com.netease.protobuf.ReadUtils.read$TYPE_INT64(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
