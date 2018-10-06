// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: MapPro.proto

package com.hatchery.test.protobuf;

public final class MapPro {
  private MapPro() {}
  public static void registerAllExtensions(
      com.google.protobuf.ExtensionRegistryLite registry) {
  }

  public static void registerAllExtensions(
      com.google.protobuf.ExtensionRegistry registry) {
    registerAllExtensions(
        (com.google.protobuf.ExtensionRegistryLite) registry);
  }
  public interface TestObjectOrBuilder extends
      // @@protoc_insertion_point(interface_extends:com.wing.hatchery.test.protobuf.TestObject)
      com.google.protobuf.MessageOrBuilder {

    /**
     * <code>map&lt;string, .com.wing.hatchery.test.protobuf.TestObject.MapVaule&gt; map = 1;</code>
     */
    int getMapCount();
    /**
     * <code>map&lt;string, .com.wing.hatchery.test.protobuf.TestObject.MapVaule&gt; map = 1;</code>
     */
    boolean containsMap(
            String key);
    /**
     * Use {@link #getMapMap()} instead.
     */
    @Deprecated
    java.util.Map<String, MapPro.TestObject.MapVaule>
    getMap();
    /**
     * <code>map&lt;string, .com.wing.hatchery.test.protobuf.TestObject.MapVaule&gt; map = 1;</code>
     */
    java.util.Map<String, MapPro.TestObject.MapVaule>
    getMapMap();
    /**
     * <code>map&lt;string, .com.wing.hatchery.test.protobuf.TestObject.MapVaule&gt; map = 1;</code>
     */

    MapPro.TestObject.MapVaule getMapOrDefault(
            String key,
            MapPro.TestObject.MapVaule defaultValue);
    /**
     * <code>map&lt;string, .com.wing.hatchery.test.protobuf.TestObject.MapVaule&gt; map = 1;</code>
     */

    MapPro.TestObject.MapVaule getMapOrThrow(
            String key);
  }
  /**
   * Protobuf type {@code com.wing.hatchery.test.protobuf.TestObject}
   */
  public  static final class TestObject extends
      com.google.protobuf.GeneratedMessageV3 implements
      // @@protoc_insertion_point(message_implements:com.wing.hatchery.test.protobuf.TestObject)
      TestObjectOrBuilder {
    // Use TestObject.newBuilder() to construct.
    private TestObject(com.google.protobuf.GeneratedMessageV3.Builder<?> builder) {
      super(builder);
    }
    private TestObject() {
    }

    @Override
    public final com.google.protobuf.UnknownFieldSet
    getUnknownFields() {
      return com.google.protobuf.UnknownFieldSet.getDefaultInstance();
    }
    public static final com.google.protobuf.Descriptors.Descriptor
        getDescriptor() {
      return MapPro.internal_static_com_wing_hatchery_test_protobuf_TestObject_descriptor;
    }

    @SuppressWarnings({"rawtypes"})
    protected com.google.protobuf.MapField internalGetMapField(
        int number) {
      switch (number) {
        case 1:
          return internalGetMap();
        default:
          throw new RuntimeException(
              "Invalid map field number: " + number);
      }
    }
    protected FieldAccessorTable
        internalGetFieldAccessorTable() {
      return MapPro.internal_static_com_wing_hatchery_test_protobuf_TestObject_fieldAccessorTable
          .ensureFieldAccessorsInitialized(
              MapPro.TestObject.class, MapPro.TestObject.Builder.class);
    }

    public interface MapVauleOrBuilder extends
        // @@protoc_insertion_point(interface_extends:com.wing.hatchery.test.protobuf.TestObject.MapVaule)
        com.google.protobuf.MessageOrBuilder {

      /**
       * <code>int32 mapValue = 1;</code>
       */
      int getMapValue();
    }
    /**
     * Protobuf type {@code com.wing.hatchery.test.protobuf.TestObject.MapVaule}
     */
    public  static final class MapVaule extends
        com.google.protobuf.GeneratedMessageV3 implements
        // @@protoc_insertion_point(message_implements:com.wing.hatchery.test.protobuf.TestObject.MapVaule)
        MapVauleOrBuilder {
      // Use MapVaule.newBuilder() to construct.
      private MapVaule(com.google.protobuf.GeneratedMessageV3.Builder<?> builder) {
        super(builder);
      }
      private MapVaule() {
        mapValue_ = 0;
      }

      @Override
      public final com.google.protobuf.UnknownFieldSet
      getUnknownFields() {
        return com.google.protobuf.UnknownFieldSet.getDefaultInstance();
      }
      public static final com.google.protobuf.Descriptors.Descriptor
          getDescriptor() {
        return MapPro.internal_static_com_wing_hatchery_test_protobuf_TestObject_MapVaule_descriptor;
      }

      protected FieldAccessorTable
          internalGetFieldAccessorTable() {
        return MapPro.internal_static_com_wing_hatchery_test_protobuf_TestObject_MapVaule_fieldAccessorTable
            .ensureFieldAccessorsInitialized(
                MapPro.TestObject.MapVaule.class, MapPro.TestObject.MapVaule.Builder.class);
      }

      public static final int MAPVALUE_FIELD_NUMBER = 1;
      private int mapValue_;
      /**
       * <code>int32 mapValue = 1;</code>
       */
      public int getMapValue() {
        return mapValue_;
      }

      public static MapPro.TestObject.MapVaule parseFrom(
          com.google.protobuf.ByteString data)
          throws com.google.protobuf.InvalidProtocolBufferException {
        return PARSER.parseFrom(data);
      }
      public static MapPro.TestObject.MapVaule parseFrom(
          com.google.protobuf.ByteString data,
          com.google.protobuf.ExtensionRegistryLite extensionRegistry)
          throws com.google.protobuf.InvalidProtocolBufferException {
        return PARSER.parseFrom(data, extensionRegistry);
      }
      public static MapPro.TestObject.MapVaule parseFrom(byte[] data)
          throws com.google.protobuf.InvalidProtocolBufferException {
        return PARSER.parseFrom(data);
      }
      public static MapPro.TestObject.MapVaule parseFrom(
          byte[] data,
          com.google.protobuf.ExtensionRegistryLite extensionRegistry)
          throws com.google.protobuf.InvalidProtocolBufferException {
        return PARSER.parseFrom(data, extensionRegistry);
      }
      public static MapPro.TestObject.MapVaule parseFrom(java.io.InputStream input)
          throws java.io.IOException {
        return com.google.protobuf.GeneratedMessageV3
            .parseWithIOException(PARSER, input);
      }
      public static MapPro.TestObject.MapVaule parseFrom(
          java.io.InputStream input,
          com.google.protobuf.ExtensionRegistryLite extensionRegistry)
          throws java.io.IOException {
        return com.google.protobuf.GeneratedMessageV3
            .parseWithIOException(PARSER, input, extensionRegistry);
      }
      public static MapPro.TestObject.MapVaule parseDelimitedFrom(java.io.InputStream input)
          throws java.io.IOException {
        return com.google.protobuf.GeneratedMessageV3
            .parseDelimitedWithIOException(PARSER, input);
      }
      public static MapPro.TestObject.MapVaule parseDelimitedFrom(
          java.io.InputStream input,
          com.google.protobuf.ExtensionRegistryLite extensionRegistry)
          throws java.io.IOException {
        return com.google.protobuf.GeneratedMessageV3
            .parseDelimitedWithIOException(PARSER, input, extensionRegistry);
      }
      public static MapPro.TestObject.MapVaule parseFrom(
          com.google.protobuf.CodedInputStream input)
          throws java.io.IOException {
        return com.google.protobuf.GeneratedMessageV3
            .parseWithIOException(PARSER, input);
      }
      public static MapPro.TestObject.MapVaule parseFrom(
          com.google.protobuf.CodedInputStream input,
          com.google.protobuf.ExtensionRegistryLite extensionRegistry)
          throws java.io.IOException {
        return com.google.protobuf.GeneratedMessageV3
            .parseWithIOException(PARSER, input, extensionRegistry);
      }

      public Builder newBuilderForType() { return newBuilder(); }
      public static Builder newBuilder() {
        return DEFAULT_INSTANCE.toBuilder();
      }
      public static Builder newBuilder(MapPro.TestObject.MapVaule prototype) {
        return DEFAULT_INSTANCE.toBuilder().mergeFrom(prototype);
      }
      public Builder toBuilder() {
        return this == DEFAULT_INSTANCE
            ? new Builder() : new Builder().mergeFrom(this);
      }

      @Override
      protected Builder newBuilderForType(
          BuilderParent parent) {
        Builder builder = new Builder(parent);
        return builder;
      }
      /**
       * Protobuf type {@code com.wing.hatchery.test.protobuf.TestObject.MapVaule}
       */
      public static final class Builder extends
          com.google.protobuf.GeneratedMessageV3.Builder<Builder> implements
          // @@protoc_insertion_point(builder_implements:com.wing.hatchery.test.protobuf.TestObject.MapVaule)
          MapPro.TestObject.MapVauleOrBuilder {
        public static final com.google.protobuf.Descriptors.Descriptor
            getDescriptor() {
          return MapPro.internal_static_com_wing_hatchery_test_protobuf_TestObject_MapVaule_descriptor;
        }

        protected FieldAccessorTable
            internalGetFieldAccessorTable() {
          return MapPro.internal_static_com_wing_hatchery_test_protobuf_TestObject_MapVaule_fieldAccessorTable
              .ensureFieldAccessorsInitialized(
                  MapPro.TestObject.MapVaule.class, MapPro.TestObject.MapVaule.Builder.class);
        }

        // Construct using com.wing.hatchery.test.protobuf.MapPro.TestObject.MapVaule.newBuilder()
        private Builder() {
          maybeForceBuilderInitialization();
        }

        private Builder(
            BuilderParent parent) {
          super(parent);
          maybeForceBuilderInitialization();
        }
        private void maybeForceBuilderInitialization() {
          if (com.google.protobuf.GeneratedMessageV3
                  .alwaysUseFieldBuilders) {
          }
        }
        public Builder clear() {
          super.clear();
          mapValue_ = 0;

          return this;
        }

        public com.google.protobuf.Descriptors.Descriptor
            getDescriptorForType() {
          return MapPro.internal_static_com_wing_hatchery_test_protobuf_TestObject_MapVaule_descriptor;
        }

        public MapPro.TestObject.MapVaule getDefaultInstanceForType() {
          return MapPro.TestObject.MapVaule.getDefaultInstance();
        }

        public MapPro.TestObject.MapVaule build() {
          MapPro.TestObject.MapVaule result = buildPartial();
          if (!result.isInitialized()) {
            throw newUninitializedMessageException(result);
          }
          return result;
        }

        public MapPro.TestObject.MapVaule buildPartial() {
          MapPro.TestObject.MapVaule result = new MapPro.TestObject.MapVaule(this);
          result.mapValue_ = mapValue_;
          onBuilt();
          return result;
        }

        public Builder clone() {
          return (Builder) super.clone();
        }
        public Builder setField(
            com.google.protobuf.Descriptors.FieldDescriptor field,
            Object value) {
          return (Builder) super.setField(field, value);
        }
        public Builder clearField(
            com.google.protobuf.Descriptors.FieldDescriptor field) {
          return (Builder) super.clearField(field);
        }
        public Builder clearOneof(
            com.google.protobuf.Descriptors.OneofDescriptor oneof) {
          return (Builder) super.clearOneof(oneof);
        }
        public Builder setRepeatedField(
            com.google.protobuf.Descriptors.FieldDescriptor field,
            int index, Object value) {
          return (Builder) super.setRepeatedField(field, index, value);
        }
        public Builder addRepeatedField(
            com.google.protobuf.Descriptors.FieldDescriptor field,
            Object value) {
          return (Builder) super.addRepeatedField(field, value);
        }

        private int mapValue_ ;
        /**
         * <code>int32 mapValue = 1;</code>
         */
        public int getMapValue() {
          return mapValue_;
        }
        /**
         * <code>int32 mapValue = 1;</code>
         */
        public Builder setMapValue(int value) {

          mapValue_ = value;
          onChanged();
          return this;
        }
        /**
         * <code>int32 mapValue = 1;</code>
         */
        public Builder clearMapValue() {

          mapValue_ = 0;
          onChanged();
          return this;
        }
        public final Builder setUnknownFields(
            final com.google.protobuf.UnknownFieldSet unknownFields) {
          return this;
        }

        public final Builder mergeUnknownFields(
            final com.google.protobuf.UnknownFieldSet unknownFields) {
          return this;
        }


        // @@protoc_insertion_point(builder_scope:com.wing.hatchery.test.protobuf.TestObject.MapVaule)
      }

      // @@protoc_insertion_point(class_scope:com.wing.hatchery.test.protobuf.TestObject.MapVaule)
      private static final MapPro.TestObject.MapVaule DEFAULT_INSTANCE;
      static {
        DEFAULT_INSTANCE = new MapPro.TestObject.MapVaule();
      }

      public static MapPro.TestObject.MapVaule getDefaultInstance() {
        return DEFAULT_INSTANCE;
      }

      private static final com.google.protobuf.Parser<MapVaule>
          PARSER = new com.google.protobuf.AbstractParser<MapVaule>() {
        public MapVaule parsePartialFrom(
            com.google.protobuf.CodedInputStream input,
            com.google.protobuf.ExtensionRegistryLite extensionRegistry)
            throws com.google.protobuf.InvalidProtocolBufferException {
          Builder builder = newBuilder();
          try {
            builder.mergeFrom(input, extensionRegistry);
          } catch (com.google.protobuf.InvalidProtocolBufferException e) {
            throw e.setUnfinishedMessage(builder.buildPartial());
          } catch (java.io.IOException e) {
            throw new com.google.protobuf.InvalidProtocolBufferException(
                e.getMessage()).setUnfinishedMessage(
                    builder.buildPartial());
          }
          return builder.buildPartial();
        }
      };

      public static com.google.protobuf.Parser<MapVaule> parser() {
        return PARSER;
      }

      @Override
      public com.google.protobuf.Parser<MapVaule> getParserForType() {
        return PARSER;
      }

      public MapPro.TestObject.MapVaule getDefaultInstanceForType() {
        return DEFAULT_INSTANCE;
      }

    }

    public static final int MAP_FIELD_NUMBER = 1;
    private static final class MapDefaultEntryHolder {
      static final com.google.protobuf.MapEntry<
          String, MapPro.TestObject.MapVaule> defaultEntry =
              com.google.protobuf.MapEntry
              .<String, MapPro.TestObject.MapVaule>newDefaultInstance(
                  MapPro.internal_static_com_wing_hatchery_test_protobuf_TestObject_MapEntry_descriptor,
                  com.google.protobuf.WireFormat.FieldType.STRING,
                  "",
                  com.google.protobuf.WireFormat.FieldType.MESSAGE,
                  MapPro.TestObject.MapVaule.getDefaultInstance());
    }
    private com.google.protobuf.MapField<
        String, MapPro.TestObject.MapVaule> map_;
    private com.google.protobuf.MapField<String, MapPro.TestObject.MapVaule>
    internalGetMap() {
      if (map_ == null) {
        return com.google.protobuf.MapField.emptyMapField(
            MapDefaultEntryHolder.defaultEntry);
      }
      return map_;
    }

    public int getMapCount() {
      return internalGetMap().getMap().size();
    }
    /**
     * <code>map&lt;string, .com.wing.hatchery.test.protobuf.TestObject.MapVaule&gt; map = 1;</code>
     */

    public boolean containsMap(
        String key) {
      if (key == null) { throw new NullPointerException(); }
      return internalGetMap().getMap().containsKey(key);
    }
    /**
     * Use {@link #getMapMap()} instead.
     */
    @Deprecated
    public java.util.Map<String, MapPro.TestObject.MapVaule> getMap() {
      return getMapMap();
    }
    /**
     * <code>map&lt;string, .com.wing.hatchery.test.protobuf.TestObject.MapVaule&gt; map = 1;</code>
     */

    public java.util.Map<String, MapPro.TestObject.MapVaule> getMapMap() {
      return internalGetMap().getMap();
    }
    /**
     * <code>map&lt;string, .com.wing.hatchery.test.protobuf.TestObject.MapVaule&gt; map = 1;</code>
     */

    public MapPro.TestObject.MapVaule getMapOrDefault(
        String key,
        MapPro.TestObject.MapVaule defaultValue) {
      if (key == null) { throw new NullPointerException(); }
      java.util.Map<String, MapPro.TestObject.MapVaule> map =
          internalGetMap().getMap();
      return map.containsKey(key) ? map.get(key) : defaultValue;
    }
    /**
     * <code>map&lt;string, .com.wing.hatchery.test.protobuf.TestObject.MapVaule&gt; map = 1;</code>
     */

    public MapPro.TestObject.MapVaule getMapOrThrow(
        String key) {
      if (key == null) { throw new NullPointerException(); }
      java.util.Map<String, MapPro.TestObject.MapVaule> map =
          internalGetMap().getMap();
      if (!map.containsKey(key)) {
        throw new IllegalArgumentException();
      }
      return map.get(key);
    }

    public static MapPro.TestObject parseFrom(
        com.google.protobuf.ByteString data)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return PARSER.parseFrom(data);
    }
    public static MapPro.TestObject parseFrom(
        com.google.protobuf.ByteString data,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return PARSER.parseFrom(data, extensionRegistry);
    }
    public static MapPro.TestObject parseFrom(byte[] data)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return PARSER.parseFrom(data);
    }
    public static MapPro.TestObject parseFrom(
        byte[] data,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return PARSER.parseFrom(data, extensionRegistry);
    }
    public static MapPro.TestObject parseFrom(java.io.InputStream input)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageV3
          .parseWithIOException(PARSER, input);
    }
    public static MapPro.TestObject parseFrom(
        java.io.InputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageV3
          .parseWithIOException(PARSER, input, extensionRegistry);
    }
    public static MapPro.TestObject parseDelimitedFrom(java.io.InputStream input)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageV3
          .parseDelimitedWithIOException(PARSER, input);
    }
    public static MapPro.TestObject parseDelimitedFrom(
        java.io.InputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageV3
          .parseDelimitedWithIOException(PARSER, input, extensionRegistry);
    }
    public static MapPro.TestObject parseFrom(
        com.google.protobuf.CodedInputStream input)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageV3
          .parseWithIOException(PARSER, input);
    }
    public static MapPro.TestObject parseFrom(
        com.google.protobuf.CodedInputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageV3
          .parseWithIOException(PARSER, input, extensionRegistry);
    }

    public Builder newBuilderForType() { return newBuilder(); }
    public static Builder newBuilder() {
      return DEFAULT_INSTANCE.toBuilder();
    }
    public static Builder newBuilder(MapPro.TestObject prototype) {
      return DEFAULT_INSTANCE.toBuilder().mergeFrom(prototype);
    }
    public Builder toBuilder() {
      return this == DEFAULT_INSTANCE
          ? new Builder() : new Builder().mergeFrom(this);
    }

    @Override
    protected Builder newBuilderForType(
        BuilderParent parent) {
      Builder builder = new Builder(parent);
      return builder;
    }
    /**
     * Protobuf type {@code com.wing.hatchery.test.protobuf.TestObject}
     */
    public static final class Builder extends
        com.google.protobuf.GeneratedMessageV3.Builder<Builder> implements
        // @@protoc_insertion_point(builder_implements:com.wing.hatchery.test.protobuf.TestObject)
        MapPro.TestObjectOrBuilder {
      public static final com.google.protobuf.Descriptors.Descriptor
          getDescriptor() {
        return MapPro.internal_static_com_wing_hatchery_test_protobuf_TestObject_descriptor;
      }

      @SuppressWarnings({"rawtypes"})
      protected com.google.protobuf.MapField internalGetMapField(
          int number) {
        switch (number) {
          case 1:
            return internalGetMap();
          default:
            throw new RuntimeException(
                "Invalid map field number: " + number);
        }
      }
      @SuppressWarnings({"rawtypes"})
      protected com.google.protobuf.MapField internalGetMutableMapField(
          int number) {
        switch (number) {
          case 1:
            return internalGetMutableMap();
          default:
            throw new RuntimeException(
                "Invalid map field number: " + number);
        }
      }
      protected FieldAccessorTable
          internalGetFieldAccessorTable() {
        return MapPro.internal_static_com_wing_hatchery_test_protobuf_TestObject_fieldAccessorTable
            .ensureFieldAccessorsInitialized(
                MapPro.TestObject.class, MapPro.TestObject.Builder.class);
      }

      // Construct using com.wing.hatchery.test.protobuf.MapPro.TestObject.newBuilder()
      private Builder() {
        maybeForceBuilderInitialization();
      }

      private Builder(
          BuilderParent parent) {
        super(parent);
        maybeForceBuilderInitialization();
      }
      private void maybeForceBuilderInitialization() {
        if (com.google.protobuf.GeneratedMessageV3
                .alwaysUseFieldBuilders) {
        }
      }
      public Builder clear() {
        super.clear();
        internalGetMutableMap().clear();
        return this;
      }

      public com.google.protobuf.Descriptors.Descriptor
          getDescriptorForType() {
        return MapPro.internal_static_com_wing_hatchery_test_protobuf_TestObject_descriptor;
      }

      public MapPro.TestObject getDefaultInstanceForType() {
        return MapPro.TestObject.getDefaultInstance();
      }

      public MapPro.TestObject build() {
        MapPro.TestObject result = buildPartial();
        if (!result.isInitialized()) {
          throw newUninitializedMessageException(result);
        }
        return result;
      }

      public MapPro.TestObject buildPartial() {
        MapPro.TestObject result = new MapPro.TestObject(this);
        int from_bitField0_ = bitField0_;
        result.map_ = internalGetMap();
        result.map_.makeImmutable();
        onBuilt();
        return result;
      }

      public Builder clone() {
        return (Builder) super.clone();
      }
      public Builder setField(
          com.google.protobuf.Descriptors.FieldDescriptor field,
          Object value) {
        return (Builder) super.setField(field, value);
      }
      public Builder clearField(
          com.google.protobuf.Descriptors.FieldDescriptor field) {
        return (Builder) super.clearField(field);
      }
      public Builder clearOneof(
          com.google.protobuf.Descriptors.OneofDescriptor oneof) {
        return (Builder) super.clearOneof(oneof);
      }
      public Builder setRepeatedField(
          com.google.protobuf.Descriptors.FieldDescriptor field,
          int index, Object value) {
        return (Builder) super.setRepeatedField(field, index, value);
      }
      public Builder addRepeatedField(
          com.google.protobuf.Descriptors.FieldDescriptor field,
          Object value) {
        return (Builder) super.addRepeatedField(field, value);
      }
      private int bitField0_;

      private com.google.protobuf.MapField<
          String, MapPro.TestObject.MapVaule> map_;
      private com.google.protobuf.MapField<String, MapPro.TestObject.MapVaule>
      internalGetMap() {
        if (map_ == null) {
          return com.google.protobuf.MapField.emptyMapField(
              MapDefaultEntryHolder.defaultEntry);
        }
        return map_;
      }
      private com.google.protobuf.MapField<String, MapPro.TestObject.MapVaule>
      internalGetMutableMap() {
        onChanged();;
        if (map_ == null) {
          map_ = com.google.protobuf.MapField.newMapField(
              MapDefaultEntryHolder.defaultEntry);
        }
        if (!map_.isMutable()) {
          map_ = map_.copy();
        }
        return map_;
      }

      public int getMapCount() {
        return internalGetMap().getMap().size();
      }
      /**
       * <code>map&lt;string, .com.wing.hatchery.test.protobuf.TestObject.MapVaule&gt; map = 1;</code>
       */

      public boolean containsMap(
          String key) {
        if (key == null) { throw new NullPointerException(); }
        return internalGetMap().getMap().containsKey(key);
      }
      /**
       * Use {@link #getMapMap()} instead.
       */
      @Deprecated
      public java.util.Map<String, MapPro.TestObject.MapVaule> getMap() {
        return getMapMap();
      }
      /**
       * <code>map&lt;string, .com.wing.hatchery.test.protobuf.TestObject.MapVaule&gt; map = 1;</code>
       */

      public java.util.Map<String, MapPro.TestObject.MapVaule> getMapMap() {
        return internalGetMap().getMap();
      }
      /**
       * <code>map&lt;string, .com.wing.hatchery.test.protobuf.TestObject.MapVaule&gt; map = 1;</code>
       */

      public MapPro.TestObject.MapVaule getMapOrDefault(
          String key,
          MapPro.TestObject.MapVaule defaultValue) {
        if (key == null) { throw new NullPointerException(); }
        java.util.Map<String, MapPro.TestObject.MapVaule> map =
            internalGetMap().getMap();
        return map.containsKey(key) ? map.get(key) : defaultValue;
      }
      /**
       * <code>map&lt;string, .com.wing.hatchery.test.protobuf.TestObject.MapVaule&gt; map = 1;</code>
       */

      public MapPro.TestObject.MapVaule getMapOrThrow(
          String key) {
        if (key == null) { throw new NullPointerException(); }
        java.util.Map<String, MapPro.TestObject.MapVaule> map =
            internalGetMap().getMap();
        if (!map.containsKey(key)) {
          throw new IllegalArgumentException();
        }
        return map.get(key);
      }

      public Builder clearMap() {
        internalGetMutableMap().getMutableMap()
            .clear();
        return this;
      }
      /**
       * <code>map&lt;string, .com.wing.hatchery.test.protobuf.TestObject.MapVaule&gt; map = 1;</code>
       */

      public Builder removeMap(
          String key) {
        if (key == null) { throw new NullPointerException(); }
        internalGetMutableMap().getMutableMap()
            .remove(key);
        return this;
      }
      /**
       * Use alternate mutation accessors instead.
       */
      @Deprecated
      public java.util.Map<String, MapPro.TestObject.MapVaule>
      getMutableMap() {
        return internalGetMutableMap().getMutableMap();
      }
      /**
       * <code>map&lt;string, .com.wing.hatchery.test.protobuf.TestObject.MapVaule&gt; map = 1;</code>
       */
      public Builder putMap(
          String key,
          MapPro.TestObject.MapVaule value) {
        if (key == null) { throw new NullPointerException(); }
        if (value == null) { throw new NullPointerException(); }
        internalGetMutableMap().getMutableMap()
            .put(key, value);
        return this;
      }
      /**
       * <code>map&lt;string, .com.wing.hatchery.test.protobuf.TestObject.MapVaule&gt; map = 1;</code>
       */

      public Builder putAllMap(
          java.util.Map<String, MapPro.TestObject.MapVaule> values) {
        internalGetMutableMap().getMutableMap()
            .putAll(values);
        return this;
      }
      public final Builder setUnknownFields(
          final com.google.protobuf.UnknownFieldSet unknownFields) {
        return this;
      }

      public final Builder mergeUnknownFields(
          final com.google.protobuf.UnknownFieldSet unknownFields) {
        return this;
      }


      // @@protoc_insertion_point(builder_scope:com.wing.hatchery.test.protobuf.TestObject)
    }

    // @@protoc_insertion_point(class_scope:com.wing.hatchery.test.protobuf.TestObject)
    private static final MapPro.TestObject DEFAULT_INSTANCE;
    static {
      DEFAULT_INSTANCE = new MapPro.TestObject();
    }

    public static MapPro.TestObject getDefaultInstance() {
      return DEFAULT_INSTANCE;
    }

    private static final com.google.protobuf.Parser<TestObject>
        PARSER = new com.google.protobuf.AbstractParser<TestObject>() {
      public TestObject parsePartialFrom(
          com.google.protobuf.CodedInputStream input,
          com.google.protobuf.ExtensionRegistryLite extensionRegistry)
          throws com.google.protobuf.InvalidProtocolBufferException {
        Builder builder = newBuilder();
        try {
          builder.mergeFrom(input, extensionRegistry);
        } catch (com.google.protobuf.InvalidProtocolBufferException e) {
          throw e.setUnfinishedMessage(builder.buildPartial());
        } catch (java.io.IOException e) {
          throw new com.google.protobuf.InvalidProtocolBufferException(
              e.getMessage()).setUnfinishedMessage(
                  builder.buildPartial());
        }
        return builder.buildPartial();
      }
    };

    public static com.google.protobuf.Parser<TestObject> parser() {
      return PARSER;
    }

    @Override
    public com.google.protobuf.Parser<TestObject> getParserForType() {
      return PARSER;
    }

    public MapPro.TestObject getDefaultInstanceForType() {
      return DEFAULT_INSTANCE;
    }

  }

  private static final com.google.protobuf.Descriptors.Descriptor
    internal_static_com_wing_hatchery_test_protobuf_TestObject_descriptor;
  private static final
    com.google.protobuf.GeneratedMessageV3.FieldAccessorTable
      internal_static_com_wing_hatchery_test_protobuf_TestObject_fieldAccessorTable;
  private static final com.google.protobuf.Descriptors.Descriptor
    internal_static_com_wing_hatchery_test_protobuf_TestObject_MapEntry_descriptor;
  private static final
    com.google.protobuf.GeneratedMessageV3.FieldAccessorTable
      internal_static_com_wing_hatchery_test_protobuf_TestObject_MapEntry_fieldAccessorTable;
  private static final com.google.protobuf.Descriptors.Descriptor
    internal_static_com_wing_hatchery_test_protobuf_TestObject_MapVaule_descriptor;
  private static final
    com.google.protobuf.GeneratedMessageV3.FieldAccessorTable
      internal_static_com_wing_hatchery_test_protobuf_TestObject_MapVaule_fieldAccessorTable;

  public static com.google.protobuf.Descriptors.FileDescriptor
      getDescriptor() {
    return descriptor;
  }
  private static  com.google.protobuf.Descriptors.FileDescriptor
      descriptor;
  static {
    String[] descriptorData = {
      "\n\014MapPro.proto\022\037com.wing.hatchery.test.p" +
      "rotobuf\"\317\001\n\nTestObject\022A\n\003map\030\001 \003(\01324.co" +
      "m.wing.hatchery.test.protobuf.TestObject" +
      ".MapEntry\032`\n\010MapEntry\022\013\n\003key\030\001 \001(\t\022C\n\005va" +
      "lue\030\002 \001(\01324.com.wing.hatchery.test.proto" +
      "buf.TestObject.MapVaule:\0028\001\032\034\n\010MapVaule\022" +
      "\020\n\010mapValue\030\001 \001(\005B\002H\002b\006proto3"
    };
    com.google.protobuf.Descriptors.FileDescriptor.InternalDescriptorAssigner assigner =
        new com.google.protobuf.Descriptors.FileDescriptor.    InternalDescriptorAssigner() {
          public com.google.protobuf.ExtensionRegistry assignDescriptors(
              com.google.protobuf.Descriptors.FileDescriptor root) {
            descriptor = root;
            return null;
          }
        };
    com.google.protobuf.Descriptors.FileDescriptor
      .internalBuildGeneratedFileFrom(descriptorData,
        new com.google.protobuf.Descriptors.FileDescriptor[] {
        }, assigner);
    internal_static_com_wing_hatchery_test_protobuf_TestObject_descriptor =
      getDescriptor().getMessageTypes().get(0);
    internal_static_com_wing_hatchery_test_protobuf_TestObject_fieldAccessorTable = new
      com.google.protobuf.GeneratedMessageV3.FieldAccessorTable(
        internal_static_com_wing_hatchery_test_protobuf_TestObject_descriptor,
        new String[] { "Map", });
    internal_static_com_wing_hatchery_test_protobuf_TestObject_MapEntry_descriptor =
      internal_static_com_wing_hatchery_test_protobuf_TestObject_descriptor.getNestedTypes().get(0);
    internal_static_com_wing_hatchery_test_protobuf_TestObject_MapEntry_fieldAccessorTable = new
      com.google.protobuf.GeneratedMessageV3.FieldAccessorTable(
        internal_static_com_wing_hatchery_test_protobuf_TestObject_MapEntry_descriptor,
        new String[] { "Key", "Value", });
    internal_static_com_wing_hatchery_test_protobuf_TestObject_MapVaule_descriptor =
      internal_static_com_wing_hatchery_test_protobuf_TestObject_descriptor.getNestedTypes().get(1);
    internal_static_com_wing_hatchery_test_protobuf_TestObject_MapVaule_fieldAccessorTable = new
      com.google.protobuf.GeneratedMessageV3.FieldAccessorTable(
        internal_static_com_wing_hatchery_test_protobuf_TestObject_MapVaule_descriptor,
        new String[] { "MapValue", });
  }

  // @@protoc_insertion_point(outer_class_scope)
}
