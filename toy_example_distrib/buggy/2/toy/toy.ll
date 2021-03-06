; ModuleID = 'toy.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.file_header = type <{ i32, i32, i16, i16, i32 }>
%struct.file_entry = type <{ [16 x i8], i32, %union.anon }>
%union.anon = type <{ float }>

@lava_val = internal global [1000000 x i32] zeroinitializer, align 16
@.str = private unnamed_addr constant [18 x i8] c"Entry: bar = %s, \00", align 1
@.str1 = private unnamed_addr constant [12 x i8] c"fdata = %f\0A\00", align 1
@.str2 = private unnamed_addr constant [14 x i8] c"intdata = %u\0A\00", align 1
@.str3 = private unnamed_addr constant [17 x i8] c"Unknown type %x\0A\00", align 1
@.str4 = private unnamed_addr constant [3 x i8] c"rb\00", align 1
@.str5 = private unnamed_addr constant [20 x i8] c"File timestamp: %u\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @lava_set(i32 %bug_num, i32 %val) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 %bug_num, i32* %1, align 4
  call void @llvm.dbg.declare(metadata !{i32* %1}, metadata !122), !dbg !123
  store i32 %val, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !124), !dbg !123
  %3 = load i32* %2, align 4, !dbg !123
  %4 = load i32* %1, align 4, !dbg !123
  %5 = zext i32 %4 to i64, !dbg !123
  %6 = getelementptr inbounds [1000000 x i32]* @lava_val, i32 0, i64 %5, !dbg !123
  store i32 %3, i32* %6, align 4, !dbg !123
  ret void, !dbg !123
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

; Function Attrs: nounwind uwtable
define i32 @lava_get(i32 %bug_num) #0 {
  %1 = alloca i32, align 4
  store i32 %bug_num, i32* %1, align 4
  call void @llvm.dbg.declare(metadata !{i32* %1}, metadata !125), !dbg !126
  %2 = load i32* %1, align 4, !dbg !126
  %3 = zext i32 %2 to i64, !dbg !126
  %4 = getelementptr inbounds [1000000 x i32]* @lava_val, i32 0, i64 %3, !dbg !126
  %5 = load i32* %4, align 4, !dbg !126
  ret i32 %5, !dbg !126
}

; Function Attrs: nounwind uwtable
define void @parse_header(%struct._IO_FILE* %f, %struct.file_header* %hdr) #0 {
  %1 = alloca %struct._IO_FILE*, align 8
  %2 = alloca %struct.file_header*, align 8
  store %struct._IO_FILE* %f, %struct._IO_FILE** %1, align 8
  call void @llvm.dbg.declare(metadata !{%struct._IO_FILE** %1}, metadata !127), !dbg !128
  store %struct.file_header* %hdr, %struct.file_header** %2, align 8
  call void @llvm.dbg.declare(metadata !{%struct.file_header** %2}, metadata !129), !dbg !128
  %3 = load %struct.file_header** %2, align 8, !dbg !130
  %4 = bitcast %struct.file_header* %3 to i8*, !dbg !130
  %5 = load %struct._IO_FILE** %1, align 8, !dbg !130
  %6 = call i64 @fread(i8* %4, i64 16, i64 1, %struct._IO_FILE* %5), !dbg !130
  %7 = icmp ne i64 1, %6, !dbg !130
  br i1 %7, label %8, label %9, !dbg !130

; <label>:8                                       ; preds = %0
  call void @exit(i32 1) #5, !dbg !132
  unreachable, !dbg !132

; <label>:9                                       ; preds = %0
  %10 = load %struct.file_header** %2, align 8, !dbg !133
  %11 = getelementptr inbounds %struct.file_header* %10, i32 0, i32 0, !dbg !133
  %12 = load i32* %11, align 1, !dbg !133
  %13 = icmp ne i32 %12, 1279350337, !dbg !133
  br i1 %13, label %14, label %15, !dbg !133

; <label>:14                                      ; preds = %9
  call void @exit(i32 1) #5, !dbg !135
  unreachable, !dbg !135

; <label>:15                                      ; preds = %9
  ret void, !dbg !136
}

declare i64 @fread(i8*, i64, i64, %struct._IO_FILE*) #2

; Function Attrs: noreturn nounwind
declare void @exit(i32) #3

; Function Attrs: nounwind uwtable
define %struct.file_entry* @parse_record(%struct._IO_FILE* %f) #0 {
  %1 = alloca %struct._IO_FILE*, align 8
  %ret = alloca %struct.file_entry*, align 8
  store %struct._IO_FILE* %f, %struct._IO_FILE** %1, align 8
  call void @llvm.dbg.declare(metadata !{%struct._IO_FILE** %1}, metadata !137), !dbg !138
  call void @llvm.dbg.declare(metadata !{%struct.file_entry** %ret}, metadata !139), !dbg !140
  %2 = call noalias i8* @malloc(i64 24) #6, !dbg !140
  %3 = bitcast i8* %2 to %struct.file_entry*, !dbg !140
  store %struct.file_entry* %3, %struct.file_entry** %ret, align 8, !dbg !140
  %4 = load %struct.file_entry** %ret, align 8, !dbg !141
  %5 = bitcast %struct.file_entry* %4 to i8*, !dbg !141
  %6 = load %struct._IO_FILE** %1, align 8, !dbg !141
  %7 = call i64 @fread(i8* %5, i64 24, i64 1, %struct._IO_FILE* %6), !dbg !141
  %8 = icmp ne i64 1, %7, !dbg !141
  br i1 %8, label %9, label %10, !dbg !141

; <label>:9                                       ; preds = %0
  call void @exit(i32 1) #5, !dbg !143
  unreachable, !dbg !143

; <label>:10                                      ; preds = %0
  %11 = load %struct.file_entry** %ret, align 8, !dbg !144
  ret %struct.file_entry* %11, !dbg !144
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #4

; Function Attrs: nounwind uwtable
define void @consume_record(%struct.file_entry* %ent) #0 {
  %1 = alloca %struct.file_entry*, align 8
  %lava_131 = alloca i32, align 4
  %kbcieiubweuhc1714636915 = alloca i32, align 4
  %2 = alloca i32, align 4
  store %struct.file_entry* %ent, %struct.file_entry** %1, align 8
  call void @llvm.dbg.declare(metadata !{%struct.file_entry** %1}, metadata !145), !dbg !146
  %3 = load %struct.file_entry** %1, align 8, !dbg !147
  %4 = getelementptr inbounds %struct.file_entry* %3, i32 0, i32 0, !dbg !147
  %5 = getelementptr inbounds [16 x i8]* %4, i32 0, i32 0, !dbg !147
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str, i32 0, i32 0), i8* %5), !dbg !147
  %7 = load %struct.file_entry** %1, align 8, !dbg !148
  %8 = getelementptr inbounds %struct.file_entry* %7, i32 0, i32 1, !dbg !148
  %9 = load i32* %8, align 1, !dbg !148
  %10 = icmp eq i32 %9, 1, !dbg !148
  br i1 %10, label %11, label %72, !dbg !148

; <label>:11                                      ; preds = %0
  %12 = load %struct.file_entry** %1, align 8, !dbg !150
  %13 = icmp ne %struct.file_entry* %12, null, !dbg !150
  br i1 %13, label %14, label %51, !dbg !150

; <label>:14                                      ; preds = %11
  %15 = load %struct.file_entry** %1, align 8, !dbg !150
  %16 = icmp ne %struct.file_entry* %15, null, !dbg !150
  br i1 %16, label %17, label %51, !dbg !150

; <label>:17                                      ; preds = %14
  call void @llvm.dbg.declare(metadata !{i32* %lava_131}, metadata !154), !dbg !156
  store i32 0, i32* %lava_131, align 4, !dbg !156
  %18 = load %struct.file_entry** %1, align 8, !dbg !157
  %19 = bitcast %struct.file_entry* %18 to i8*, !dbg !157
  %20 = getelementptr inbounds i8* %19, i64 0, !dbg !157
  %21 = load i8* %20, align 1, !dbg !157
  %22 = zext i8 %21 to i32, !dbg !157
  %23 = shl i32 %22, 0, !dbg !157
  %24 = load i32* %lava_131, align 4, !dbg !157
  %25 = or i32 %24, %23, !dbg !157
  store i32 %25, i32* %lava_131, align 4, !dbg !157
  %26 = load %struct.file_entry** %1, align 8, !dbg !157
  %27 = bitcast %struct.file_entry* %26 to i8*, !dbg !157
  %28 = getelementptr inbounds i8* %27, i64 1, !dbg !157
  %29 = load i8* %28, align 1, !dbg !157
  %30 = zext i8 %29 to i32, !dbg !157
  %31 = shl i32 %30, 8, !dbg !157
  %32 = load i32* %lava_131, align 4, !dbg !157
  %33 = or i32 %32, %31, !dbg !157
  store i32 %33, i32* %lava_131, align 4, !dbg !157
  %34 = load %struct.file_entry** %1, align 8, !dbg !157
  %35 = bitcast %struct.file_entry* %34 to i8*, !dbg !157
  %36 = getelementptr inbounds i8* %35, i64 2, !dbg !157
  %37 = load i8* %36, align 1, !dbg !157
  %38 = zext i8 %37 to i32, !dbg !157
  %39 = shl i32 %38, 16, !dbg !157
  %40 = load i32* %lava_131, align 4, !dbg !157
  %41 = or i32 %40, %39, !dbg !157
  store i32 %41, i32* %lava_131, align 4, !dbg !157
  %42 = load %struct.file_entry** %1, align 8, !dbg !157
  %43 = bitcast %struct.file_entry* %42 to i8*, !dbg !157
  %44 = getelementptr inbounds i8* %43, i64 3, !dbg !157
  %45 = load i8* %44, align 1, !dbg !157
  %46 = zext i8 %45 to i32, !dbg !157
  %47 = shl i32 %46, 24, !dbg !157
  %48 = load i32* %lava_131, align 4, !dbg !157
  %49 = or i32 %48, %47, !dbg !157
  store i32 %49, i32* %lava_131, align 4, !dbg !157
  %50 = load i32* %lava_131, align 4, !dbg !157
  call void @lava_set(i32 131, i32 %50), !dbg !157
  br label %51, !dbg !158

; <label>:51                                      ; preds = %17, %14, %11
  call void @llvm.dbg.declare(metadata !{i32* %kbcieiubweuhc1714636915}, metadata !159), !dbg !160
  %52 = call i32 @lava_get(i32 131), !dbg !160
  %53 = call i32 @lava_get(i32 131), !dbg !160
  %54 = icmp eq i32 1818326494, %53, !dbg !160
  br i1 %54, label %58, label %55, !dbg !160

; <label>:55                                      ; preds = %51
  %56 = call i32 @lava_get(i32 131), !dbg !160
  %57 = icmp eq i32 -562732692, %56, !dbg !160
  br label %58, !dbg !160

; <label>:58                                      ; preds = %55, %51
  %59 = phi i1 [ true, %51 ], [ %57, %55 ]
  %60 = zext i1 %59 to i32, !dbg !160
  %61 = mul i32 %52, %60, !dbg !160
  %62 = zext i32 %61 to i64, !dbg !160
  %63 = getelementptr inbounds i8* getelementptr inbounds ([12 x i8]* @.str1, i32 0, i32 0), i64 %62, !dbg !160
  %64 = load %struct.file_entry** %1, align 8, !dbg !160
  %65 = getelementptr inbounds %struct.file_entry* %64, i32 0, i32 2, !dbg !160
  %66 = bitcast %union.anon* %65 to float*, !dbg !160
  %67 = load float* %66, align 1, !dbg !160
  %68 = fpext float %67 to double, !dbg !160
  %69 = call i32 (i8*, ...)* @printf(i8* %63, double %68), !dbg !160
  store i32 %69, i32* %kbcieiubweuhc1714636915, align 4, !dbg !160
  %70 = load i32* %kbcieiubweuhc1714636915, align 4, !dbg !160
  store i32 %70, i32* %2, !dbg !160
  %71 = load i32* %2, !dbg !160
  br label %89, !dbg !161

; <label>:72                                      ; preds = %0
  %73 = load %struct.file_entry** %1, align 8, !dbg !162
  %74 = getelementptr inbounds %struct.file_entry* %73, i32 0, i32 1, !dbg !162
  %75 = load i32* %74, align 1, !dbg !162
  %76 = icmp eq i32 %75, 2, !dbg !162
  br i1 %76, label %77, label %83, !dbg !162

; <label>:77                                      ; preds = %72
  %78 = load %struct.file_entry** %1, align 8, !dbg !164
  %79 = getelementptr inbounds %struct.file_entry* %78, i32 0, i32 2, !dbg !164
  %80 = bitcast %union.anon* %79 to i32*, !dbg !164
  %81 = load i32* %80, align 1, !dbg !164
  %82 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str2, i32 0, i32 0), i32 %81), !dbg !164
  br label %88, !dbg !166

; <label>:83                                      ; preds = %72
  %84 = load %struct.file_entry** %1, align 8, !dbg !167
  %85 = getelementptr inbounds %struct.file_entry* %84, i32 0, i32 1, !dbg !167
  %86 = load i32* %85, align 1, !dbg !167
  %87 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([17 x i8]* @.str3, i32 0, i32 0), i32 %86), !dbg !167
  call void @exit(i32 1) #5, !dbg !169
  unreachable, !dbg !169

; <label>:88                                      ; preds = %77
  br label %89

; <label>:89                                      ; preds = %88, %58
  %90 = load %struct.file_entry** %1, align 8, !dbg !170
  %91 = bitcast %struct.file_entry* %90 to i8*, !dbg !170
  call void @free(i8* %91) #6, !dbg !170
  ret void, !dbg !171
}

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind
declare void @free(i8*) #4

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %f = alloca %struct._IO_FILE*, align 8
  %head = alloca %struct.file_header, align 1
  %i = alloca i32, align 4
  %ent = alloca %struct.file_entry*, align 8
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !172), !dbg !173
  store i8** %argv, i8*** %3, align 8
  call void @llvm.dbg.declare(metadata !{i8*** %3}, metadata !174), !dbg !173
  call void @llvm.dbg.declare(metadata !{%struct._IO_FILE** %f}, metadata !175), !dbg !176
  %4 = load i8*** %3, align 8, !dbg !176
  %5 = getelementptr inbounds i8** %4, i64 1, !dbg !176
  %6 = load i8** %5, align 8, !dbg !176
  %7 = call %struct._IO_FILE* @fopen(i8* %6, i8* getelementptr inbounds ([3 x i8]* @.str4, i32 0, i32 0)), !dbg !176
  store %struct._IO_FILE* %7, %struct._IO_FILE** %f, align 8, !dbg !176
  call void @llvm.dbg.declare(metadata !{%struct.file_header* %head}, metadata !177), !dbg !178
  %8 = load %struct._IO_FILE** %f, align 8, !dbg !179
  call void @parse_header(%struct._IO_FILE* %8, %struct.file_header* %head), !dbg !179
  %9 = getelementptr inbounds %struct.file_header* %head, i32 0, i32 4, !dbg !180
  %10 = load i32* %9, align 1, !dbg !180
  %11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([20 x i8]* @.str5, i32 0, i32 0), i32 %10), !dbg !180
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !181), !dbg !182
  store i32 0, i32* %i, align 4, !dbg !183
  br label %12, !dbg !183

; <label>:12                                      ; preds = %22, %0
  %13 = load i32* %i, align 4, !dbg !183
  %14 = getelementptr inbounds %struct.file_header* %head, i32 0, i32 2, !dbg !183
  %15 = load i16* %14, align 1, !dbg !183
  %16 = zext i16 %15 to i32, !dbg !183
  %17 = icmp ult i32 %13, %16, !dbg !183
  br i1 %17, label %18, label %25, !dbg !183

; <label>:18                                      ; preds = %12
  call void @llvm.dbg.declare(metadata !{%struct.file_entry** %ent}, metadata !185), !dbg !187
  %19 = load %struct._IO_FILE** %f, align 8, !dbg !187
  %20 = call %struct.file_entry* @parse_record(%struct._IO_FILE* %19), !dbg !187
  store %struct.file_entry* %20, %struct.file_entry** %ent, align 8, !dbg !187
  %21 = load %struct.file_entry** %ent, align 8, !dbg !188
  call void @consume_record(%struct.file_entry* %21), !dbg !188
  br label %22, !dbg !189

; <label>:22                                      ; preds = %18
  %23 = load i32* %i, align 4, !dbg !183
  %24 = add i32 %23, 1, !dbg !183
  store i32 %24, i32* %i, align 4, !dbg !183
  br label %12, !dbg !183

; <label>:25                                      ; preds = %12
  ret i32 0, !dbg !190
}

declare %struct._IO_FILE* @fopen(i8*, i8*) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn nounwind }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!119, !120}
!llvm.ident = !{!121}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)", i1 false, metadata !"", i32 0, metadata !2, metadata !7, metadata !8, metadata !114, metadata !7, metadata !""} ; [ DW_TAG_compile_unit ] [/home/klee/toy_example_distrib/buggy/2/toy/toy.c] [DW_LANG_C99]
!1 = metadata !{metadata !"toy.c", metadata !"/home/klee/toy_example_distrib/buggy/2/toy"}
!2 = metadata !{metadata !3}
!3 = metadata !{i32 786436, metadata !1, null, metadata !"", i32 15, i64 32, i64 32, i32 0, i32 0, null, metadata !4, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 15, size 32, align 32, offset 0] [def] [from ]
!4 = metadata !{metadata !5, metadata !6}
!5 = metadata !{i32 786472, metadata !"TYPEA", i64 1} ; [ DW_TAG_enumerator ] [TYPEA :: 1]
!6 = metadata !{i32 786472, metadata !"TYPEB", i64 2} ; [ DW_TAG_enumerator ] [TYPEB :: 2]
!7 = metadata !{i32 0}
!8 = metadata !{metadata !9, metadata !14, metadata !17, metadata !89, metadata !107, metadata !110}
!9 = metadata !{i32 786478, metadata !1, metadata !10, metadata !"lava_set", metadata !"lava_set", metadata !"", i32 5, metadata !11, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32)* @lava_set, null, null, metadata !7, i32 5} ; [ DW_TAG_subprogram ] [line 5] [def] [lava_set]
!10 = metadata !{i32 786473, metadata !1}         ; [ DW_TAG_file_type ] [/home/klee/toy_example_distrib/buggy/2/toy/toy.c]
!11 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !12, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!12 = metadata !{null, metadata !13, metadata !13}
!13 = metadata !{i32 786468, null, null, metadata !"unsigned int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!14 = metadata !{i32 786478, metadata !1, metadata !10, metadata !"lava_get", metadata !"lava_get", metadata !"", i32 7, metadata !15, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32)* @lava_get, null, null, metadata !7, i32 7} ; [ DW_TAG_subprogram ] [line 7] [def] [lava_get]
!15 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !16, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!16 = metadata !{metadata !13, metadata !13}
!17 = metadata !{i32 786478, metadata !1, metadata !10, metadata !"parse_header", metadata !"parse_header", metadata !"", i32 37, metadata !18, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (%struct._IO_FILE*, %struct.file_header*)* @parse_header, null, null, metadata !7, i32 37} ; [ DW_TAG_subprogram ] [line 37] [def] [parse_header]
!18 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !19, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!19 = metadata !{null, metadata !20, metadata !78}
!20 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !21} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from FILE]
!21 = metadata !{i32 786454, metadata !1, null, metadata !"FILE", i32 48, i64 0, i64 0, i64 0, i32 0, metadata !22} ; [ DW_TAG_typedef ] [FILE] [line 48, size 0, align 0, offset 0] [from _IO_FILE]
!22 = metadata !{i32 786451, metadata !23, null, metadata !"_IO_FILE", i32 245, i64 1728, i64 64, i32 0, i32 0, null, metadata !24, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [_IO_FILE] [line 245, size 1728, align 64, offset 0] [def] [from ]
!23 = metadata !{metadata !"/usr/include/libio.h", metadata !"/home/klee/toy_example_distrib/buggy/2/toy"}
!24 = metadata !{metadata !25, metadata !27, metadata !30, metadata !31, metadata !32, metadata !33, metadata !34, metadata !35, metadata !36, metadata !37, metadata !38, metadata !39, metadata !40, metadata !48, metadata !49, metadata !50, metadata !51, metadata !54, metadata !56, metadata !58, metadata !62, metadata !64, metadata !66, metadata !67, metadata !68, metadata !69, metadata !70, metadata !73, metadata !74}
!25 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_flags", i32 246, i64 32, i64 32, i64 0, i32 0, metadata !26} ; [ DW_TAG_member ] [_flags] [line 246, size 32, align 32, offset 0] [from int]
!26 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!27 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_read_ptr", i32 251, i64 64, i64 64, i64 64, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_read_ptr] [line 251, size 64, align 64, offset 64] [from ]
!28 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !29} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!29 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!30 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_read_end", i32 252, i64 64, i64 64, i64 128, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_read_end] [line 252, size 64, align 64, offset 128] [from ]
!31 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_read_base", i32 253, i64 64, i64 64, i64 192, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_read_base] [line 253, size 64, align 64, offset 192] [from ]
!32 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_write_base", i32 254, i64 64, i64 64, i64 256, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_write_base] [line 254, size 64, align 64, offset 256] [from ]
!33 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_write_ptr", i32 255, i64 64, i64 64, i64 320, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_write_ptr] [line 255, size 64, align 64, offset 320] [from ]
!34 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_write_end", i32 256, i64 64, i64 64, i64 384, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_write_end] [line 256, size 64, align 64, offset 384] [from ]
!35 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_buf_base", i32 257, i64 64, i64 64, i64 448, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_buf_base] [line 257, size 64, align 64, offset 448] [from ]
!36 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_buf_end", i32 258, i64 64, i64 64, i64 512, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_buf_end] [line 258, size 64, align 64, offset 512] [from ]
!37 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_save_base", i32 260, i64 64, i64 64, i64 576, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_save_base] [line 260, size 64, align 64, offset 576] [from ]
!38 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_backup_base", i32 261, i64 64, i64 64, i64 640, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_backup_base] [line 261, size 64, align 64, offset 640] [from ]
!39 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_save_end", i32 262, i64 64, i64 64, i64 704, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_save_end] [line 262, size 64, align 64, offset 704] [from ]
!40 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_markers", i32 264, i64 64, i64 64, i64 768, i32 0, metadata !41} ; [ DW_TAG_member ] [_markers] [line 264, size 64, align 64, offset 768] [from ]
!41 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !42} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from _IO_marker]
!42 = metadata !{i32 786451, metadata !23, null, metadata !"_IO_marker", i32 160, i64 192, i64 64, i32 0, i32 0, null, metadata !43, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [_IO_marker] [line 160, size 192, align 64, offset 0] [def] [from ]
!43 = metadata !{metadata !44, metadata !45, metadata !47}
!44 = metadata !{i32 786445, metadata !23, metadata !42, metadata !"_next", i32 161, i64 64, i64 64, i64 0, i32 0, metadata !41} ; [ DW_TAG_member ] [_next] [line 161, size 64, align 64, offset 0] [from ]
!45 = metadata !{i32 786445, metadata !23, metadata !42, metadata !"_sbuf", i32 162, i64 64, i64 64, i64 64, i32 0, metadata !46} ; [ DW_TAG_member ] [_sbuf] [line 162, size 64, align 64, offset 64] [from ]
!46 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !22} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from _IO_FILE]
!47 = metadata !{i32 786445, metadata !23, metadata !42, metadata !"_pos", i32 166, i64 32, i64 32, i64 128, i32 0, metadata !26} ; [ DW_TAG_member ] [_pos] [line 166, size 32, align 32, offset 128] [from int]
!48 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_chain", i32 266, i64 64, i64 64, i64 832, i32 0, metadata !46} ; [ DW_TAG_member ] [_chain] [line 266, size 64, align 64, offset 832] [from ]
!49 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_fileno", i32 268, i64 32, i64 32, i64 896, i32 0, metadata !26} ; [ DW_TAG_member ] [_fileno] [line 268, size 32, align 32, offset 896] [from int]
!50 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_flags2", i32 272, i64 32, i64 32, i64 928, i32 0, metadata !26} ; [ DW_TAG_member ] [_flags2] [line 272, size 32, align 32, offset 928] [from int]
!51 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_old_offset", i32 274, i64 64, i64 64, i64 960, i32 0, metadata !52} ; [ DW_TAG_member ] [_old_offset] [line 274, size 64, align 64, offset 960] [from __off_t]
!52 = metadata !{i32 786454, metadata !23, null, metadata !"__off_t", i32 131, i64 0, i64 0, i64 0, i32 0, metadata !53} ; [ DW_TAG_typedef ] [__off_t] [line 131, size 0, align 0, offset 0] [from long int]
!53 = metadata !{i32 786468, null, null, metadata !"long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!54 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_cur_column", i32 278, i64 16, i64 16, i64 1024, i32 0, metadata !55} ; [ DW_TAG_member ] [_cur_column] [line 278, size 16, align 16, offset 1024] [from unsigned short]
!55 = metadata !{i32 786468, null, null, metadata !"unsigned short", i32 0, i64 16, i64 16, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned short] [line 0, size 16, align 16, offset 0, enc DW_ATE_unsigned]
!56 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_vtable_offset", i32 279, i64 8, i64 8, i64 1040, i32 0, metadata !57} ; [ DW_TAG_member ] [_vtable_offset] [line 279, size 8, align 8, offset 1040] [from signed char]
!57 = metadata !{i32 786468, null, null, metadata !"signed char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [signed char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!58 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_shortbuf", i32 280, i64 8, i64 8, i64 1048, i32 0, metadata !59} ; [ DW_TAG_member ] [_shortbuf] [line 280, size 8, align 8, offset 1048] [from ]
!59 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 8, i64 8, i32 0, i32 0, metadata !29, metadata !60, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 8, align 8, offset 0] [from char]
!60 = metadata !{metadata !61}
!61 = metadata !{i32 786465, i64 0, i64 1}        ; [ DW_TAG_subrange_type ] [0, 0]
!62 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_lock", i32 284, i64 64, i64 64, i64 1088, i32 0, metadata !63} ; [ DW_TAG_member ] [_lock] [line 284, size 64, align 64, offset 1088] [from ]
!63 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!64 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_offset", i32 293, i64 64, i64 64, i64 1152, i32 0, metadata !65} ; [ DW_TAG_member ] [_offset] [line 293, size 64, align 64, offset 1152] [from __off64_t]
!65 = metadata !{i32 786454, metadata !23, null, metadata !"__off64_t", i32 132, i64 0, i64 0, i64 0, i32 0, metadata !53} ; [ DW_TAG_typedef ] [__off64_t] [line 132, size 0, align 0, offset 0] [from long int]
!66 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"__pad1", i32 302, i64 64, i64 64, i64 1216, i32 0, metadata !63} ; [ DW_TAG_member ] [__pad1] [line 302, size 64, align 64, offset 1216] [from ]
!67 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"__pad2", i32 303, i64 64, i64 64, i64 1280, i32 0, metadata !63} ; [ DW_TAG_member ] [__pad2] [line 303, size 64, align 64, offset 1280] [from ]
!68 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"__pad3", i32 304, i64 64, i64 64, i64 1344, i32 0, metadata !63} ; [ DW_TAG_member ] [__pad3] [line 304, size 64, align 64, offset 1344] [from ]
!69 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"__pad4", i32 305, i64 64, i64 64, i64 1408, i32 0, metadata !63} ; [ DW_TAG_member ] [__pad4] [line 305, size 64, align 64, offset 1408] [from ]
!70 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"__pad5", i32 306, i64 64, i64 64, i64 1472, i32 0, metadata !71} ; [ DW_TAG_member ] [__pad5] [line 306, size 64, align 64, offset 1472] [from size_t]
!71 = metadata !{i32 786454, metadata !23, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !72} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!72 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!73 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_mode", i32 308, i64 32, i64 32, i64 1536, i32 0, metadata !26} ; [ DW_TAG_member ] [_mode] [line 308, size 32, align 32, offset 1536] [from int]
!74 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_unused2", i32 310, i64 160, i64 8, i64 1568, i32 0, metadata !75} ; [ DW_TAG_member ] [_unused2] [line 310, size 160, align 8, offset 1568] [from ]
!75 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 160, i64 8, i32 0, i32 0, metadata !29, metadata !76, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 160, align 8, offset 0] [from char]
!76 = metadata !{metadata !77}
!77 = metadata !{i32 786465, i64 0, i64 20}       ; [ DW_TAG_subrange_type ] [0, 19]
!78 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !79} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from file_header]
!79 = metadata !{i32 786454, metadata !1, null, metadata !"file_header", i32 26, i64 0, i64 0, i64 0, i32 0, metadata !80} ; [ DW_TAG_typedef ] [file_header] [line 26, size 0, align 0, offset 0] [from ]
!80 = metadata !{i32 786451, metadata !1, null, metadata !"", i32 20, i64 128, i64 8, i32 0, i32 0, null, metadata !81, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [line 20, size 128, align 8, offset 0] [def] [from ]
!81 = metadata !{metadata !82, metadata !84, metadata !85, metadata !87, metadata !88}
!82 = metadata !{i32 786445, metadata !1, metadata !80, metadata !"magic", i32 21, i64 32, i64 32, i64 0, i32 0, metadata !83} ; [ DW_TAG_member ] [magic] [line 21, size 32, align 32, offset 0] [from uint32_t]
!83 = metadata !{i32 786454, metadata !1, null, metadata !"uint32_t", i32 51, i64 0, i64 0, i64 0, i32 0, metadata !13} ; [ DW_TAG_typedef ] [uint32_t] [line 51, size 0, align 0, offset 0] [from unsigned int]
!84 = metadata !{i32 786445, metadata !1, metadata !80, metadata !"reserved", i32 22, i64 32, i64 32, i64 32, i32 0, metadata !83} ; [ DW_TAG_member ] [reserved] [line 22, size 32, align 32, offset 32] [from uint32_t]
!85 = metadata !{i32 786445, metadata !1, metadata !80, metadata !"num_recs", i32 23, i64 16, i64 16, i64 64, i32 0, metadata !86} ; [ DW_TAG_member ] [num_recs] [line 23, size 16, align 16, offset 64] [from uint16_t]
!86 = metadata !{i32 786454, metadata !1, null, metadata !"uint16_t", i32 49, i64 0, i64 0, i64 0, i32 0, metadata !55} ; [ DW_TAG_typedef ] [uint16_t] [line 49, size 0, align 0, offset 0] [from unsigned short]
!87 = metadata !{i32 786445, metadata !1, metadata !80, metadata !"flags", i32 24, i64 16, i64 16, i64 80, i32 0, metadata !86} ; [ DW_TAG_member ] [flags] [line 24, size 16, align 16, offset 80] [from uint16_t]
!88 = metadata !{i32 786445, metadata !1, metadata !80, metadata !"timestamp", i32 25, i64 32, i64 32, i64 96, i32 0, metadata !83} ; [ DW_TAG_member ] [timestamp] [line 25, size 32, align 32, offset 96] [from uint32_t]
!89 = metadata !{i32 786478, metadata !1, metadata !10, metadata !"parse_record", metadata !"parse_record", metadata !"", i32 44, metadata !90, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, %struct.file_entry* (%struct._IO_FILE*)* @parse_record, null, null, metadata !7, i32 44} ; [ DW_TAG_subprogram ] [line 44] [def] [parse_record]
!90 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !91, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!91 = metadata !{metadata !92, metadata !20}
!92 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !93} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from file_entry]
!93 = metadata !{i32 786454, metadata !1, null, metadata !"file_entry", i32 35, i64 0, i64 0, i64 0, i32 0, metadata !94} ; [ DW_TAG_typedef ] [file_entry] [line 35, size 0, align 0, offset 0] [from ]
!94 = metadata !{i32 786451, metadata !1, null, metadata !"", i32 28, i64 192, i64 8, i32 0, i32 0, null, metadata !95, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [line 28, size 192, align 8, offset 0] [def] [from ]
!95 = metadata !{metadata !96, metadata !100, metadata !101}
!96 = metadata !{i32 786445, metadata !1, metadata !94, metadata !"bar", i32 29, i64 128, i64 8, i64 0, i32 0, metadata !97} ; [ DW_TAG_member ] [bar] [line 29, size 128, align 8, offset 0] [from ]
!97 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 128, i64 8, i32 0, i32 0, metadata !29, metadata !98, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 128, align 8, offset 0] [from char]
!98 = metadata !{metadata !99}
!99 = metadata !{i32 786465, i64 0, i64 16}       ; [ DW_TAG_subrange_type ] [0, 15]
!100 = metadata !{i32 786445, metadata !1, metadata !94, metadata !"type", i32 30, i64 32, i64 32, i64 128, i32 0, metadata !83} ; [ DW_TAG_member ] [type] [line 30, size 32, align 32, offset 128] [from uint32_t]
!101 = metadata !{i32 786445, metadata !1, metadata !94, metadata !"data", i32 34, i64 32, i64 8, i64 160, i32 0, metadata !102} ; [ DW_TAG_member ] [data] [line 34, size 32, align 8, offset 160] [from ]
!102 = metadata !{i32 786455, metadata !1, metadata !94, metadata !"", i32 31, i64 32, i64 8, i64 0, i32 0, null, metadata !103, i32 0, null, null, null} ; [ DW_TAG_union_type ] [line 31, size 32, align 8, offset 0] [def] [from ]
!103 = metadata !{metadata !104, metadata !106}
!104 = metadata !{i32 786445, metadata !1, metadata !102, metadata !"fdata", i32 32, i64 32, i64 32, i64 0, i32 0, metadata !105} ; [ DW_TAG_member ] [fdata] [line 32, size 32, align 32, offset 0] [from float]
!105 = metadata !{i32 786468, null, null, metadata !"float", i32 0, i64 32, i64 32, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [float] [line 0, size 32, align 32, offset 0, enc DW_ATE_float]
!106 = metadata !{i32 786445, metadata !1, metadata !102, metadata !"intdata", i32 33, i64 32, i64 32, i64 0, i32 0, metadata !83} ; [ DW_TAG_member ] [intdata] [line 33, size 32, align 32, offset 0] [from uint32_t]
!107 = metadata !{i32 786478, metadata !1, metadata !10, metadata !"consume_record", metadata !"consume_record", metadata !"", i32 51, metadata !108, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (%struct.file_entry*)* @consume_record, null, null, metadata !7, i32 51} ; [ DW_TAG_subprogram ] [line 51] [def] [consume_record]
!108 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !109, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!109 = metadata !{null, metadata !92}
!110 = metadata !{i32 786478, metadata !1, metadata !10, metadata !"main", metadata !"main", metadata !"", i32 68, metadata !111, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i8**)* @main, null, null, metadata !7, i32 68} ; [ DW_TAG_subprogram ] [line 68] [def] [main]
!111 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !112, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!112 = metadata !{metadata !26, metadata !26, metadata !113}
!113 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !28} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!114 = metadata !{metadata !115}
!115 = metadata !{i32 786484, i32 0, null, metadata !"lava_val", metadata !"lava_val", metadata !"", metadata !10, i32 3, metadata !116, i32 1, i32 1, [1000000 x i32]* @lava_val, null} ; [ DW_TAG_variable ] [lava_val] [line 3] [local] [def]
!116 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 32000000, i64 32, i32 0, i32 0, metadata !13, metadata !117, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 32000000, align 32, offset 0] [from unsigned int]
!117 = metadata !{metadata !118}
!118 = metadata !{i32 786465, i64 0, i64 1000000} ; [ DW_TAG_subrange_type ] [0, 999999]
!119 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!120 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!121 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!122 = metadata !{i32 786689, metadata !9, metadata !"bug_num", metadata !10, i32 16777221, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [bug_num] [line 5]
!123 = metadata !{i32 5, i32 0, metadata !9, null}
!124 = metadata !{i32 786689, metadata !9, metadata !"val", metadata !10, i32 33554437, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [val] [line 5]
!125 = metadata !{i32 786689, metadata !14, metadata !"bug_num", metadata !10, i32 16777223, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [bug_num] [line 7]
!126 = metadata !{i32 7, i32 0, metadata !14, null}
!127 = metadata !{i32 786689, metadata !17, metadata !"f", metadata !10, i32 16777253, metadata !20, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [f] [line 37]
!128 = metadata !{i32 37, i32 0, metadata !17, null}
!129 = metadata !{i32 786689, metadata !17, metadata !"hdr", metadata !10, i32 33554469, metadata !78, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [hdr] [line 37]
!130 = metadata !{i32 38, i32 0, metadata !131, null}
!131 = metadata !{i32 786443, metadata !1, metadata !17, i32 38, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/2/toy/toy.c]
!132 = metadata !{i32 39, i32 0, metadata !131, null}
!133 = metadata !{i32 40, i32 0, metadata !134, null}
!134 = metadata !{i32 786443, metadata !1, metadata !17, i32 40, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/2/toy/toy.c]
!135 = metadata !{i32 41, i32 0, metadata !134, null}
!136 = metadata !{i32 42, i32 0, metadata !17, null}
!137 = metadata !{i32 786689, metadata !89, metadata !"f", metadata !10, i32 16777260, metadata !20, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [f] [line 44]
!138 = metadata !{i32 44, i32 0, metadata !89, null}
!139 = metadata !{i32 786688, metadata !89, metadata !"ret", metadata !10, i32 45, metadata !92, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ret] [line 45]
!140 = metadata !{i32 45, i32 0, metadata !89, null}
!141 = metadata !{i32 46, i32 0, metadata !142, null}
!142 = metadata !{i32 786443, metadata !1, metadata !89, i32 46, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/2/toy/toy.c]
!143 = metadata !{i32 47, i32 0, metadata !142, null}
!144 = metadata !{i32 48, i32 0, metadata !89, null}
!145 = metadata !{i32 786689, metadata !107, metadata !"ent", metadata !10, i32 16777267, metadata !92, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [ent] [line 51]
!146 = metadata !{i32 51, i32 0, metadata !107, null}
!147 = metadata !{i32 52, i32 0, metadata !107, null}
!148 = metadata !{i32 53, i32 0, metadata !149, null}
!149 = metadata !{i32 786443, metadata !1, metadata !107, i32 53, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/2/toy/toy.c]
!150 = metadata !{i32 54, i32 0, metadata !151, null}
!151 = metadata !{i32 786443, metadata !1, metadata !152, i32 54, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/2/toy/toy.c]
!152 = metadata !{i32 786443, metadata !1, metadata !153, i32 54, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/2/toy/toy.c]
!153 = metadata !{i32 786443, metadata !1, metadata !149, i32 53, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/2/toy/toy.c]
!154 = metadata !{i32 786688, metadata !155, metadata !"lava_131", metadata !10, i32 54, metadata !26, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [lava_131] [line 54]
!155 = metadata !{i32 786443, metadata !1, metadata !151, i32 54, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/2/toy/toy.c]
!156 = metadata !{i32 54, i32 0, metadata !155, null}
!157 = metadata !{i32 55, i32 0, metadata !155, null}
!158 = metadata !{i32 56, i32 0, metadata !155, null}
!159 = metadata !{i32 786688, metadata !152, metadata !"kbcieiubweuhc1714636915", metadata !10, i32 56, metadata !26, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [kbcieiubweuhc1714636915] [line 56]
!160 = metadata !{i32 56, i32 0, metadata !152, null}
!161 = metadata !{i32 57, i32 0, metadata !153, null}
!162 = metadata !{i32 58, i32 0, metadata !163, null} ; [ DW_TAG_imported_module ]
!163 = metadata !{i32 786443, metadata !1, metadata !149, i32 58, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/2/toy/toy.c]
!164 = metadata !{i32 59, i32 0, metadata !165, null}
!165 = metadata !{i32 786443, metadata !1, metadata !163, i32 58, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/2/toy/toy.c]
!166 = metadata !{i32 60, i32 0, metadata !165, null}
!167 = metadata !{i32 62, i32 0, metadata !168, null}
!168 = metadata !{i32 786443, metadata !1, metadata !163, i32 61, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/2/toy/toy.c]
!169 = metadata !{i32 63, i32 0, metadata !168, null}
!170 = metadata !{i32 65, i32 0, metadata !107, null}
!171 = metadata !{i32 66, i32 0, metadata !107, null}
!172 = metadata !{i32 786689, metadata !110, metadata !"argc", metadata !10, i32 16777284, metadata !26, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [argc] [line 68]
!173 = metadata !{i32 68, i32 0, metadata !110, null}
!174 = metadata !{i32 786689, metadata !110, metadata !"argv", metadata !10, i32 33554500, metadata !113, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [argv] [line 68]
!175 = metadata !{i32 786688, metadata !110, metadata !"f", metadata !10, i32 69, metadata !20, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 69]
!176 = metadata !{i32 69, i32 0, metadata !110, null}
!177 = metadata !{i32 786688, metadata !110, metadata !"head", metadata !10, i32 70, metadata !79, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [head] [line 70]
!178 = metadata !{i32 70, i32 0, metadata !110, null}
!179 = metadata !{i32 72, i32 0, metadata !110, null}
!180 = metadata !{i32 73, i32 0, metadata !110, null}
!181 = metadata !{i32 786688, metadata !110, metadata !"i", metadata !10, i32 75, metadata !13, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 75]
!182 = metadata !{i32 75, i32 0, metadata !110, null}
!183 = metadata !{i32 76, i32 0, metadata !184, null}
!184 = metadata !{i32 786443, metadata !1, metadata !110, i32 76, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/2/toy/toy.c]
!185 = metadata !{i32 786688, metadata !186, metadata !"ent", metadata !10, i32 77, metadata !92, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ent] [line 77]
!186 = metadata !{i32 786443, metadata !1, metadata !184, i32 76, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/2/toy/toy.c]
!187 = metadata !{i32 77, i32 0, metadata !186, null}
!188 = metadata !{i32 78, i32 0, metadata !186, null}
!189 = metadata !{i32 79, i32 0, metadata !186, null}
!190 = metadata !{i32 80, i32 0, metadata !110, null}
