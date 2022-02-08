; ModuleID = 'test1.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [6 x i8] c"input\00", align 1
@.str1 = private unnamed_addr constant [12 x i8] c"klee_choose\00", align 1
@.str12 = private unnamed_addr constant [59 x i8] c"/tmp/monniaux/klee/runtime/Intrinsic/klee_div_zero_check.c\00", align 1
@.str123 = private unnamed_addr constant [15 x i8] c"divide by zero\00", align 1
@.str2 = private unnamed_addr constant [8 x i8] c"div.err\00", align 1
@.str3 = private unnamed_addr constant [8 x i8] c"IGNORED\00", align 1
@.str14 = private unnamed_addr constant [16 x i8] c"overshift error\00", align 1
@.str25 = private unnamed_addr constant [14 x i8] c"overshift.err\00", align 1
@.str6 = private unnamed_addr constant [50 x i8] c"/tmp/monniaux/klee/runtime/Intrinsic/klee_range.c\00", align 1
@.str17 = private unnamed_addr constant [14 x i8] c"invalid range\00", align 1
@.str28 = private unnamed_addr constant [5 x i8] c"user\00", align 1

; Function Attrs: nounwind uwtable
define i32 @check_arg(i32 %a) #0 {
entry:
  %retval = alloca i32, align 4
  %a.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  %0 = load i32* %a.addr, align 4, !dbg !135
  %cmp = icmp sgt i32 %0, 10, !dbg !135
  br i1 %cmp, label %if.then, label %if.else, !dbg !135

if.then:                                          ; preds = %entry
  store i32 0, i32* %retval, !dbg !137
  br label %return, !dbg !137

if.else:                                          ; preds = %entry
  %1 = load i32* %a.addr, align 4, !dbg !138
  %cmp1 = icmp sle i32 %1, 10, !dbg !138
  br i1 %cmp1, label %if.then2, label %if.end3, !dbg !138

if.then2:                                         ; preds = %if.else
  store i32 1, i32* %retval, !dbg !140
  br label %return, !dbg !140

if.end3:                                          ; preds = %if.else
  store i32 0, i32* %retval, !dbg !141
  br label %return, !dbg !141

return:                                           ; preds = %if.end3, %if.then2, %if.then
  %2 = load i32* %retval, !dbg !142
  ret i32 %2, !dbg !142
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %input = alloca i32, align 4
  store i32 0, i32* %retval
  %0 = bitcast i32* %input to i8*, !dbg !143
  call void @klee_make_symbolic(i8* %0, i64 4, i8* getelementptr inbounds ([6 x i8]* @.str, i32 0, i32 0)), !dbg !143
  %1 = load i32* %input, align 4, !dbg !144
  %call = call i32 @check_arg(i32 %1), !dbg !144
  ret i32 %call, !dbg !144
}

declare void @klee_make_symbolic(i8*, i64, i8*) #2

; Function Attrs: nounwind uwtable
define i64 @klee_choose(i64 %n) #3 {
entry:
  %x = alloca i64, align 8
  %0 = bitcast i64* %x to i8*, !dbg !145
  call void @klee_make_symbolic(i8* %0, i64 8, i8* getelementptr inbounds ([12 x i8]* @.str1, i64 0, i64 0)) #6, !dbg !145
  %1 = load i64* %x, align 8, !dbg !146, !tbaa !148
  %cmp = icmp ult i64 %1, %n, !dbg !146
  br i1 %cmp, label %if.end, label %if.then, !dbg !146

if.then:                                          ; preds = %entry
  call void @klee_silent_exit(i32 0) #7, !dbg !152
  unreachable, !dbg !152

if.end:                                           ; preds = %entry
  ret i64 %1, !dbg !153
}

; Function Attrs: noreturn
declare void @klee_silent_exit(i32) #4

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

; Function Attrs: nounwind uwtable
define void @klee_div_zero_check(i64 %z) #3 {
entry:
  %cmp = icmp eq i64 %z, 0, !dbg !154
  br i1 %cmp, label %if.then, label %if.end, !dbg !154

if.then:                                          ; preds = %entry
  tail call void @klee_report_error(i8* getelementptr inbounds ([59 x i8]* @.str12, i64 0, i64 0), i32 14, i8* getelementptr inbounds ([15 x i8]* @.str123, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str2, i64 0, i64 0)) #7, !dbg !156
  unreachable, !dbg !156

if.end:                                           ; preds = %entry
  ret void, !dbg !157
}

; Function Attrs: noreturn
declare void @klee_report_error(i8*, i32, i8*, i8*) #4

; Function Attrs: nounwind uwtable
define i32 @klee_int(i8* %name) #3 {
entry:
  %x = alloca i32, align 4
  %0 = bitcast i32* %x to i8*, !dbg !158
  call void @klee_make_symbolic(i8* %0, i64 4, i8* %name) #6, !dbg !158
  %1 = load i32* %x, align 4, !dbg !159, !tbaa !160
  ret i32 %1, !dbg !159
}

; Function Attrs: nounwind uwtable
define void @klee_overshift_check(i64 %bitWidth, i64 %shift) #3 {
entry:
  %cmp = icmp ult i64 %shift, %bitWidth, !dbg !162
  br i1 %cmp, label %if.end, label %if.then, !dbg !162

if.then:                                          ; preds = %entry
  tail call void @klee_report_error(i8* getelementptr inbounds ([8 x i8]* @.str3, i64 0, i64 0), i32 0, i8* getelementptr inbounds ([16 x i8]* @.str14, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8]* @.str25, i64 0, i64 0)) #7, !dbg !164
  unreachable, !dbg !164

if.end:                                           ; preds = %entry
  ret void, !dbg !166
}

; Function Attrs: nounwind uwtable
define i32 @klee_range(i32 %start, i32 %end, i8* %name) #3 {
entry:
  %x = alloca i32, align 4
  %cmp = icmp slt i32 %start, %end, !dbg !167
  br i1 %cmp, label %if.end, label %if.then, !dbg !167

if.then:                                          ; preds = %entry
  call void @klee_report_error(i8* getelementptr inbounds ([50 x i8]* @.str6, i64 0, i64 0), i32 17, i8* getelementptr inbounds ([14 x i8]* @.str17, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str28, i64 0, i64 0)) #7, !dbg !169
  unreachable, !dbg !169

if.end:                                           ; preds = %entry
  %add = add nsw i32 %start, 1, !dbg !170
  %cmp1 = icmp eq i32 %add, %end, !dbg !170
  br i1 %cmp1, label %return, label %if.else, !dbg !170

if.else:                                          ; preds = %if.end
  %0 = bitcast i32* %x to i8*, !dbg !172
  call void @klee_make_symbolic(i8* %0, i64 4, i8* %name) #6, !dbg !172
  %cmp3 = icmp eq i32 %start, 0, !dbg !174
  %1 = load i32* %x, align 4, !dbg !176, !tbaa !160
  br i1 %cmp3, label %if.then4, label %if.else7, !dbg !174

if.then4:                                         ; preds = %if.else
  %cmp5 = icmp ult i32 %1, %end, !dbg !176
  %conv6 = zext i1 %cmp5 to i64, !dbg !176
  call void @klee_assume(i64 %conv6) #6, !dbg !176
  br label %if.end14, !dbg !178

if.else7:                                         ; preds = %if.else
  %cmp8 = icmp sge i32 %1, %start, !dbg !179
  %conv10 = zext i1 %cmp8 to i64, !dbg !179
  call void @klee_assume(i64 %conv10) #6, !dbg !179
  %2 = load i32* %x, align 4, !dbg !181, !tbaa !160
  %cmp11 = icmp slt i32 %2, %end, !dbg !181
  %conv13 = zext i1 %cmp11 to i64, !dbg !181
  call void @klee_assume(i64 %conv13) #6, !dbg !181
  br label %if.end14

if.end14:                                         ; preds = %if.else7, %if.then4
  %3 = load i32* %x, align 4, !dbg !182, !tbaa !160
  br label %return, !dbg !182

return:                                           ; preds = %if.end14, %if.end
  %retval.0 = phi i32 [ %3, %if.end14 ], [ %start, %if.end ]
  ret i32 %retval.0, !dbg !183
}

declare void @klee_assume(i64) #5

; Function Attrs: nounwind uwtable
define weak i8* @memcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #3 {
entry:
  %cmp3 = icmp eq i64 %len, 0, !dbg !184
  br i1 %cmp3, label %while.end, label %while.body.preheader, !dbg !184

while.body.preheader:                             ; preds = %entry
  %n.vec = and i64 %len, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %0 = add i64 %len, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %while.body.preheader
  %scevgep7 = getelementptr i8* %srcaddr, i64 %0
  %scevgep = getelementptr i8* %destaddr, i64 %0
  %bound1 = icmp uge i8* %scevgep, %srcaddr
  %bound0 = icmp uge i8* %scevgep7, %destaddr
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %srcaddr, i64 %n.vec
  %ptr.ind.end9 = getelementptr i8* %destaddr, i64 %n.vec
  %rev.ind.end = sub i64 %len, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %srcaddr, i64 %index
  %next.gep106 = getelementptr i8* %destaddr, i64 %index
  %1 = bitcast i8* %next.gep to <16 x i8>*, !dbg !185
  %wide.load = load <16 x i8>* %1, align 1, !dbg !185
  %next.gep.sum282 = or i64 %index, 16, !dbg !185
  %2 = getelementptr i8* %srcaddr, i64 %next.gep.sum282, !dbg !185
  %3 = bitcast i8* %2 to <16 x i8>*, !dbg !185
  %wide.load203 = load <16 x i8>* %3, align 1, !dbg !185
  %4 = bitcast i8* %next.gep106 to <16 x i8>*, !dbg !185
  store <16 x i8> %wide.load, <16 x i8>* %4, align 1, !dbg !185
  %next.gep106.sum299 = or i64 %index, 16, !dbg !185
  %5 = getelementptr i8* %destaddr, i64 %next.gep106.sum299, !dbg !185
  %6 = bitcast i8* %5 to <16 x i8>*, !dbg !185
  store <16 x i8> %wide.load203, <16 x i8>* %6, align 1, !dbg !185
  %index.next = add i64 %index, 32
  %7 = icmp eq i64 %index.next, %n.vec
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !186

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %while.body.preheader
  %resume.val = phi i8* [ %srcaddr, %while.body.preheader ], [ %srcaddr, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val8 = phi i8* [ %destaddr, %while.body.preheader ], [ %destaddr, %vector.memcheck ], [ %ptr.ind.end9, %vector.body ]
  %resume.val10 = phi i64 [ %len, %while.body.preheader ], [ %len, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %while.body.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %len
  br i1 %cmp.n, label %while.end, label %while.body

while.body:                                       ; preds = %while.body, %middle.block
  %src.06 = phi i8* [ %incdec.ptr, %while.body ], [ %resume.val, %middle.block ]
  %dest.05 = phi i8* [ %incdec.ptr1, %while.body ], [ %resume.val8, %middle.block ]
  %len.addr.04 = phi i64 [ %dec, %while.body ], [ %resume.val10, %middle.block ]
  %dec = add i64 %len.addr.04, -1, !dbg !184
  %incdec.ptr = getelementptr inbounds i8* %src.06, i64 1, !dbg !185
  %8 = load i8* %src.06, align 1, !dbg !185, !tbaa !189
  %incdec.ptr1 = getelementptr inbounds i8* %dest.05, i64 1, !dbg !185
  store i8 %8, i8* %dest.05, align 1, !dbg !185, !tbaa !189
  %cmp = icmp eq i64 %dec, 0, !dbg !184
  br i1 %cmp, label %while.end, label %while.body, !dbg !184, !llvm.loop !190

while.end:                                        ; preds = %while.body, %middle.block, %entry
  ret i8* %destaddr, !dbg !191
}

; Function Attrs: nounwind uwtable
define weak i8* @memmove(i8* %dst, i8* %src, i64 %count) #3 {
entry:
  %cmp = icmp eq i8* %src, %dst, !dbg !192
  br i1 %cmp, label %return, label %if.end, !dbg !192

if.end:                                           ; preds = %entry
  %cmp1 = icmp ugt i8* %src, %dst, !dbg !194
  br i1 %cmp1, label %while.cond.preheader, label %if.else, !dbg !194

while.cond.preheader:                             ; preds = %if.end
  %tobool27 = icmp eq i64 %count, 0, !dbg !196
  br i1 %tobool27, label %return, label %while.body.preheader, !dbg !196

while.body.preheader:                             ; preds = %while.cond.preheader
  %n.vec = and i64 %count, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %0 = add i64 %count, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %while.body.preheader
  %scevgep37 = getelementptr i8* %src, i64 %0
  %scevgep = getelementptr i8* %dst, i64 %0
  %bound1 = icmp uge i8* %scevgep, %src
  %bound0 = icmp uge i8* %scevgep37, %dst
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %src, i64 %n.vec
  %ptr.ind.end39 = getelementptr i8* %dst, i64 %n.vec
  %rev.ind.end = sub i64 %count, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %src, i64 %index
  %next.gep136 = getelementptr i8* %dst, i64 %index
  %1 = bitcast i8* %next.gep to <16 x i8>*, !dbg !196
  %wide.load = load <16 x i8>* %1, align 1, !dbg !196
  %next.gep.sum610 = or i64 %index, 16, !dbg !196
  %2 = getelementptr i8* %src, i64 %next.gep.sum610, !dbg !196
  %3 = bitcast i8* %2 to <16 x i8>*, !dbg !196
  %wide.load233 = load <16 x i8>* %3, align 1, !dbg !196
  %4 = bitcast i8* %next.gep136 to <16 x i8>*, !dbg !196
  store <16 x i8> %wide.load, <16 x i8>* %4, align 1, !dbg !196
  %next.gep136.sum627 = or i64 %index, 16, !dbg !196
  %5 = getelementptr i8* %dst, i64 %next.gep136.sum627, !dbg !196
  %6 = bitcast i8* %5 to <16 x i8>*, !dbg !196
  store <16 x i8> %wide.load233, <16 x i8>* %6, align 1, !dbg !196
  %index.next = add i64 %index, 32
  %7 = icmp eq i64 %index.next, %n.vec
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !198

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %while.body.preheader
  %resume.val = phi i8* [ %src, %while.body.preheader ], [ %src, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val38 = phi i8* [ %dst, %while.body.preheader ], [ %dst, %vector.memcheck ], [ %ptr.ind.end39, %vector.body ]
  %resume.val40 = phi i64 [ %count, %while.body.preheader ], [ %count, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %while.body.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %count
  br i1 %cmp.n, label %return, label %while.body

while.body:                                       ; preds = %while.body, %middle.block
  %b.030 = phi i8* [ %incdec.ptr, %while.body ], [ %resume.val, %middle.block ]
  %a.029 = phi i8* [ %incdec.ptr3, %while.body ], [ %resume.val38, %middle.block ]
  %count.addr.028 = phi i64 [ %dec, %while.body ], [ %resume.val40, %middle.block ]
  %dec = add i64 %count.addr.028, -1, !dbg !196
  %incdec.ptr = getelementptr inbounds i8* %b.030, i64 1, !dbg !196
  %8 = load i8* %b.030, align 1, !dbg !196, !tbaa !189
  %incdec.ptr3 = getelementptr inbounds i8* %a.029, i64 1, !dbg !196
  store i8 %8, i8* %a.029, align 1, !dbg !196, !tbaa !189
  %tobool = icmp eq i64 %dec, 0, !dbg !196
  br i1 %tobool, label %return, label %while.body, !dbg !196, !llvm.loop !199

if.else:                                          ; preds = %if.end
  %sub = add i64 %count, -1, !dbg !200
  %tobool832 = icmp eq i64 %count, 0, !dbg !202
  br i1 %tobool832, label %return, label %while.body9.lr.ph, !dbg !202

while.body9.lr.ph:                                ; preds = %if.else
  %add.ptr5 = getelementptr inbounds i8* %src, i64 %sub, !dbg !203
  %add.ptr = getelementptr inbounds i8* %dst, i64 %sub, !dbg !200
  %n.vec241 = and i64 %count, -32
  %cmp.zero243 = icmp eq i64 %n.vec241, 0
  %9 = add i64 %count, -1
  br i1 %cmp.zero243, label %middle.block236, label %vector.memcheck250

vector.memcheck250:                               ; preds = %while.body9.lr.ph
  %scevgep245 = getelementptr i8* %src, i64 %9
  %scevgep244 = getelementptr i8* %dst, i64 %9
  %bound1247 = icmp ule i8* %scevgep245, %dst
  %bound0246 = icmp ule i8* %scevgep244, %src
  %memcheck.conflict249 = and i1 %bound0246, %bound1247
  %add.ptr5.sum = sub i64 %sub, %n.vec241
  %rev.ptr.ind.end = getelementptr i8* %src, i64 %add.ptr5.sum
  %add.ptr.sum = sub i64 %sub, %n.vec241
  %rev.ptr.ind.end255 = getelementptr i8* %dst, i64 %add.ptr.sum
  %rev.ind.end257 = sub i64 %count, %n.vec241
  br i1 %memcheck.conflict249, label %middle.block236, label %vector.body235

vector.body235:                                   ; preds = %vector.body235, %vector.memcheck250
  %index238 = phi i64 [ %index.next260, %vector.body235 ], [ 0, %vector.memcheck250 ]
  %add.ptr5.sum465 = sub i64 %sub, %index238
  %add.ptr.sum497 = sub i64 %sub, %index238
  %next.gep262.sum = add i64 %add.ptr5.sum465, -15, !dbg !202
  %10 = getelementptr i8* %src, i64 %next.gep262.sum, !dbg !202
  %11 = bitcast i8* %10 to <16 x i8>*, !dbg !202
  %wide.load460 = load <16 x i8>* %11, align 1, !dbg !202
  %reverse = shufflevector <16 x i8> %wide.load460, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !202
  %.sum = add i64 %add.ptr5.sum465, -31, !dbg !202
  %12 = getelementptr i8* %src, i64 %.sum, !dbg !202
  %13 = bitcast i8* %12 to <16 x i8>*, !dbg !202
  %wide.load461 = load <16 x i8>* %13, align 1, !dbg !202
  %reverse462 = shufflevector <16 x i8> %wide.load461, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !202
  %reverse463 = shufflevector <16 x i8> %reverse, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !202
  %next.gep359.sum = add i64 %add.ptr.sum497, -15, !dbg !202
  %14 = getelementptr i8* %dst, i64 %next.gep359.sum, !dbg !202
  %15 = bitcast i8* %14 to <16 x i8>*, !dbg !202
  store <16 x i8> %reverse463, <16 x i8>* %15, align 1, !dbg !202
  %reverse464 = shufflevector <16 x i8> %reverse462, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !202
  %.sum531 = add i64 %add.ptr.sum497, -31, !dbg !202
  %16 = getelementptr i8* %dst, i64 %.sum531, !dbg !202
  %17 = bitcast i8* %16 to <16 x i8>*, !dbg !202
  store <16 x i8> %reverse464, <16 x i8>* %17, align 1, !dbg !202
  %index.next260 = add i64 %index238, 32
  %18 = icmp eq i64 %index.next260, %n.vec241
  br i1 %18, label %middle.block236, label %vector.body235, !llvm.loop !204

middle.block236:                                  ; preds = %vector.body235, %vector.memcheck250, %while.body9.lr.ph
  %resume.val251 = phi i8* [ %add.ptr5, %while.body9.lr.ph ], [ %add.ptr5, %vector.memcheck250 ], [ %rev.ptr.ind.end, %vector.body235 ]
  %resume.val253 = phi i8* [ %add.ptr, %while.body9.lr.ph ], [ %add.ptr, %vector.memcheck250 ], [ %rev.ptr.ind.end255, %vector.body235 ]
  %resume.val256 = phi i64 [ %count, %while.body9.lr.ph ], [ %count, %vector.memcheck250 ], [ %rev.ind.end257, %vector.body235 ]
  %new.indc.resume.val258 = phi i64 [ 0, %while.body9.lr.ph ], [ 0, %vector.memcheck250 ], [ %n.vec241, %vector.body235 ]
  %cmp.n259 = icmp eq i64 %new.indc.resume.val258, %count
  br i1 %cmp.n259, label %return, label %while.body9

while.body9:                                      ; preds = %while.body9, %middle.block236
  %b.135 = phi i8* [ %incdec.ptr10, %while.body9 ], [ %resume.val251, %middle.block236 ]
  %a.134 = phi i8* [ %incdec.ptr11, %while.body9 ], [ %resume.val253, %middle.block236 ]
  %count.addr.133 = phi i64 [ %dec7, %while.body9 ], [ %resume.val256, %middle.block236 ]
  %dec7 = add i64 %count.addr.133, -1, !dbg !202
  %incdec.ptr10 = getelementptr inbounds i8* %b.135, i64 -1, !dbg !202
  %19 = load i8* %b.135, align 1, !dbg !202, !tbaa !189
  %incdec.ptr11 = getelementptr inbounds i8* %a.134, i64 -1, !dbg !202
  store i8 %19, i8* %a.134, align 1, !dbg !202, !tbaa !189
  %tobool8 = icmp eq i64 %dec7, 0, !dbg !202
  br i1 %tobool8, label %return, label %while.body9, !dbg !202, !llvm.loop !205

return:                                           ; preds = %while.body9, %middle.block236, %if.else, %while.body, %middle.block, %while.cond.preheader, %entry
  ret i8* %dst, !dbg !206
}

; Function Attrs: nounwind uwtable
define weak i8* @mempcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #3 {
entry:
  %cmp3 = icmp eq i64 %len, 0, !dbg !207
  br i1 %cmp3, label %while.end, label %while.body.preheader, !dbg !207

while.body.preheader:                             ; preds = %entry
  %n.vec = and i64 %len, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %0 = add i64 %len, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %while.body.preheader
  %scevgep8 = getelementptr i8* %srcaddr, i64 %0
  %scevgep7 = getelementptr i8* %destaddr, i64 %0
  %bound1 = icmp uge i8* %scevgep7, %srcaddr
  %bound0 = icmp uge i8* %scevgep8, %destaddr
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %srcaddr, i64 %n.vec
  %ptr.ind.end10 = getelementptr i8* %destaddr, i64 %n.vec
  %rev.ind.end = sub i64 %len, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %srcaddr, i64 %index
  %next.gep107 = getelementptr i8* %destaddr, i64 %index
  %1 = bitcast i8* %next.gep to <16 x i8>*, !dbg !208
  %wide.load = load <16 x i8>* %1, align 1, !dbg !208
  %next.gep.sum283 = or i64 %index, 16, !dbg !208
  %2 = getelementptr i8* %srcaddr, i64 %next.gep.sum283, !dbg !208
  %3 = bitcast i8* %2 to <16 x i8>*, !dbg !208
  %wide.load204 = load <16 x i8>* %3, align 1, !dbg !208
  %4 = bitcast i8* %next.gep107 to <16 x i8>*, !dbg !208
  store <16 x i8> %wide.load, <16 x i8>* %4, align 1, !dbg !208
  %next.gep107.sum300 = or i64 %index, 16, !dbg !208
  %5 = getelementptr i8* %destaddr, i64 %next.gep107.sum300, !dbg !208
  %6 = bitcast i8* %5 to <16 x i8>*, !dbg !208
  store <16 x i8> %wide.load204, <16 x i8>* %6, align 1, !dbg !208
  %index.next = add i64 %index, 32
  %7 = icmp eq i64 %index.next, %n.vec
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !209

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %while.body.preheader
  %resume.val = phi i8* [ %srcaddr, %while.body.preheader ], [ %srcaddr, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val9 = phi i8* [ %destaddr, %while.body.preheader ], [ %destaddr, %vector.memcheck ], [ %ptr.ind.end10, %vector.body ]
  %resume.val11 = phi i64 [ %len, %while.body.preheader ], [ %len, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %while.body.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %len
  br i1 %cmp.n, label %while.cond.while.end_crit_edge, label %while.body

while.body:                                       ; preds = %while.body, %middle.block
  %src.06 = phi i8* [ %incdec.ptr, %while.body ], [ %resume.val, %middle.block ]
  %dest.05 = phi i8* [ %incdec.ptr1, %while.body ], [ %resume.val9, %middle.block ]
  %len.addr.04 = phi i64 [ %dec, %while.body ], [ %resume.val11, %middle.block ]
  %dec = add i64 %len.addr.04, -1, !dbg !207
  %incdec.ptr = getelementptr inbounds i8* %src.06, i64 1, !dbg !208
  %8 = load i8* %src.06, align 1, !dbg !208, !tbaa !189
  %incdec.ptr1 = getelementptr inbounds i8* %dest.05, i64 1, !dbg !208
  store i8 %8, i8* %dest.05, align 1, !dbg !208, !tbaa !189
  %cmp = icmp eq i64 %dec, 0, !dbg !207
  br i1 %cmp, label %while.cond.while.end_crit_edge, label %while.body, !dbg !207, !llvm.loop !210

while.cond.while.end_crit_edge:                   ; preds = %while.body, %middle.block
  %scevgep = getelementptr i8* %destaddr, i64 %len
  br label %while.end, !dbg !207

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %entry
  %dest.0.lcssa = phi i8* [ %scevgep, %while.cond.while.end_crit_edge ], [ %destaddr, %entry ]
  ret i8* %dest.0.lcssa, !dbg !211
}

; Function Attrs: nounwind uwtable
define weak i8* @memset(i8* %dst, i32 %s, i64 %count) #3 {
entry:
  %cmp2 = icmp eq i64 %count, 0, !dbg !212
  br i1 %cmp2, label %while.end, label %while.body.lr.ph, !dbg !212

while.body.lr.ph:                                 ; preds = %entry
  %conv = trunc i32 %s to i8, !dbg !213
  br label %while.body, !dbg !212

while.body:                                       ; preds = %while.body, %while.body.lr.ph
  %a.04 = phi i8* [ %dst, %while.body.lr.ph ], [ %incdec.ptr, %while.body ]
  %count.addr.03 = phi i64 [ %count, %while.body.lr.ph ], [ %dec, %while.body ]
  %dec = add i64 %count.addr.03, -1, !dbg !212
  %incdec.ptr = getelementptr inbounds i8* %a.04, i64 1, !dbg !213
  store volatile i8 %conv, i8* %a.04, align 1, !dbg !213, !tbaa !189
  %cmp = icmp eq i64 %dec, 0, !dbg !212
  br i1 %cmp, label %while.end, label %while.body, !dbg !212

while.end:                                        ; preds = %while.body, %entry
  ret i8* %dst, !dbg !214
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nobuiltin nounwind }
attributes #7 = { nobuiltin noreturn nounwind }

!llvm.dbg.cu = !{!0, !13, !25, !35, !48, !59, !71, !89, !103, !117}
!llvm.module.flags = !{!132, !133}
!llvm.ident = !{!134, !134, !134, !134, !134, !134, !134, !134, !134, !134}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home/
!1 = metadata !{metadata !"test1.c", metadata !"/home/t/teharia/Documents/MOCA/TP8/src/keygenning_klee"}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4, metadata !10}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"check_arg", metadata !"check_arg", metadata !"", i32 5, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32)* @check_arg, null, null, metadata !2, i32 5} ; [ DW_
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/home/t/teharia/Documents/MOCA/TP8/src/keygenning_klee/test1.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !9}
!8 = metadata !{i32 786454, metadata !1, null, metadata !"BOOL", i32 3, i64 0, i64 0, i64 0, i32 0, metadata !9} ; [ DW_TAG_typedef ] [BOOL] [line 3, size 0, align 0, offset 0] [from int]
!9 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!10 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"main", metadata !"main", metadata !"", i32 15, metadata !11, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, i32 ()* @main, null, null, metadata !2, i32 15} ; [ DW_TAG_subprogram ]
!11 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !12, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!12 = metadata !{metadata !9}
!13 = metadata !{i32 786449, metadata !14, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !15, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/tmp/
!14 = metadata !{metadata !"/tmp/monniaux/klee/runtime/Intrinsic/klee_choose.c", metadata !"/tmp/monniaux/klee-build/runtime/Intrinsic"}
!15 = metadata !{metadata !16}
!16 = metadata !{i32 786478, metadata !14, metadata !17, metadata !"klee_choose", metadata !"klee_choose", metadata !"", i32 12, metadata !18, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i64 (i64)* @klee_choose, null, null, metadata !22, i32
!17 = metadata !{i32 786473, metadata !14}        ; [ DW_TAG_file_type ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/klee_choose.c]
!18 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !19, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!19 = metadata !{metadata !20, metadata !20}
!20 = metadata !{i32 786454, metadata !14, null, metadata !"uintptr_t", i32 122, i64 0, i64 0, i64 0, i32 0, metadata !21} ; [ DW_TAG_typedef ] [uintptr_t] [line 122, size 0, align 0, offset 0] [from long unsigned int]
!21 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!22 = metadata !{metadata !23, metadata !24}
!23 = metadata !{i32 786689, metadata !16, metadata !"n", metadata !17, i32 16777228, metadata !20, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 12]
!24 = metadata !{i32 786688, metadata !16, metadata !"x", metadata !17, i32 13, metadata !20, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 13]
!25 = metadata !{i32 786449, metadata !26, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !27, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/tmp/
!26 = metadata !{metadata !"/tmp/monniaux/klee/runtime/Intrinsic/klee_div_zero_check.c", metadata !"/tmp/monniaux/klee-build/runtime/Intrinsic"}
!27 = metadata !{metadata !28}
!28 = metadata !{i32 786478, metadata !26, metadata !29, metadata !"klee_div_zero_check", metadata !"klee_div_zero_check", metadata !"", i32 12, metadata !30, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64)* @klee_div_zero_check, null
!29 = metadata !{i32 786473, metadata !26}        ; [ DW_TAG_file_type ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/klee_div_zero_check.c]
!30 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !31, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!31 = metadata !{null, metadata !32}
!32 = metadata !{i32 786468, null, null, metadata !"long long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!33 = metadata !{metadata !34}
!34 = metadata !{i32 786689, metadata !28, metadata !"z", metadata !29, i32 16777228, metadata !32, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [z] [line 12]
!35 = metadata !{i32 786449, metadata !36, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !37, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/tmp/
!36 = metadata !{metadata !"/tmp/monniaux/klee/runtime/Intrinsic/klee_int.c", metadata !"/tmp/monniaux/klee-build/runtime/Intrinsic"}
!37 = metadata !{metadata !38}
!38 = metadata !{i32 786478, metadata !36, metadata !39, metadata !"klee_int", metadata !"klee_int", metadata !"", i32 13, metadata !40, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*)* @klee_int, null, null, metadata !45, i32 13} ; [ 
!39 = metadata !{i32 786473, metadata !36}        ; [ DW_TAG_file_type ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/klee_int.c]
!40 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !41, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!41 = metadata !{metadata !9, metadata !42}
!42 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !43} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!43 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !44} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!44 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!45 = metadata !{metadata !46, metadata !47}
!46 = metadata !{i32 786689, metadata !38, metadata !"name", metadata !39, i32 16777229, metadata !42, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!47 = metadata !{i32 786688, metadata !38, metadata !"x", metadata !39, i32 14, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!48 = metadata !{i32 786449, metadata !49, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !50, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/tmp/
!49 = metadata !{metadata !"/tmp/monniaux/klee/runtime/Intrinsic/klee_overshift_check.c", metadata !"/tmp/monniaux/klee-build/runtime/Intrinsic"}
!50 = metadata !{metadata !51}
!51 = metadata !{i32 786478, metadata !49, metadata !52, metadata !"klee_overshift_check", metadata !"klee_overshift_check", metadata !"", i32 20, metadata !53, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64, i64)* @klee_overshift_che
!52 = metadata !{i32 786473, metadata !49}        ; [ DW_TAG_file_type ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/klee_overshift_check.c]
!53 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !54, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!54 = metadata !{null, metadata !55, metadata !55}
!55 = metadata !{i32 786468, null, null, metadata !"long long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!56 = metadata !{metadata !57, metadata !58}
!57 = metadata !{i32 786689, metadata !51, metadata !"bitWidth", metadata !52, i32 16777236, metadata !55, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [bitWidth] [line 20]
!58 = metadata !{i32 786689, metadata !51, metadata !"shift", metadata !52, i32 33554452, metadata !55, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [shift] [line 20]
!59 = metadata !{i32 786449, metadata !60, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !61, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/tmp/
!60 = metadata !{metadata !"/tmp/monniaux/klee/runtime/Intrinsic/klee_range.c", metadata !"/tmp/monniaux/klee-build/runtime/Intrinsic"}
!61 = metadata !{metadata !62}
!62 = metadata !{i32 786478, metadata !60, metadata !63, metadata !"klee_range", metadata !"klee_range", metadata !"", i32 13, metadata !64, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i32, i8*)* @klee_range, null, null, metadata !
!63 = metadata !{i32 786473, metadata !60}        ; [ DW_TAG_file_type ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/klee_range.c]
!64 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !65, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!65 = metadata !{metadata !9, metadata !9, metadata !9, metadata !42}
!66 = metadata !{metadata !67, metadata !68, metadata !69, metadata !70}
!67 = metadata !{i32 786689, metadata !62, metadata !"start", metadata !63, i32 16777229, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [start] [line 13]
!68 = metadata !{i32 786689, metadata !62, metadata !"end", metadata !63, i32 33554445, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [end] [line 13]
!69 = metadata !{i32 786689, metadata !62, metadata !"name", metadata !63, i32 50331661, metadata !42, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!70 = metadata !{i32 786688, metadata !62, metadata !"x", metadata !63, i32 14, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!71 = metadata !{i32 786449, metadata !72, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !73, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/tmp/
!72 = metadata !{metadata !"/tmp/monniaux/klee/runtime/Intrinsic/memcpy.c", metadata !"/tmp/monniaux/klee-build/runtime/Intrinsic"}
!73 = metadata !{metadata !74}
!74 = metadata !{i32 786478, metadata !72, metadata !75, metadata !"memcpy", metadata !"memcpy", metadata !"", i32 12, metadata !76, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memcpy, null, null, metadata !82, i32 12} 
!75 = metadata !{i32 786473, metadata !72}        ; [ DW_TAG_file_type ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/memcpy.c]
!76 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !77, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!77 = metadata !{metadata !78, metadata !78, metadata !79, metadata !81}
!78 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!79 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !80} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!80 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from ]
!81 = metadata !{i32 786454, metadata !72, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !21} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!82 = metadata !{metadata !83, metadata !84, metadata !85, metadata !86, metadata !88}
!83 = metadata !{i32 786689, metadata !74, metadata !"destaddr", metadata !75, i32 16777228, metadata !78, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 12]
!84 = metadata !{i32 786689, metadata !74, metadata !"srcaddr", metadata !75, i32 33554444, metadata !79, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 12]
!85 = metadata !{i32 786689, metadata !74, metadata !"len", metadata !75, i32 50331660, metadata !81, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 12]
!86 = metadata !{i32 786688, metadata !74, metadata !"dest", metadata !75, i32 13, metadata !87, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 13]
!87 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !44} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!88 = metadata !{i32 786688, metadata !74, metadata !"src", metadata !75, i32 14, metadata !42, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 14]
!89 = metadata !{i32 786449, metadata !90, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !91, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/tmp/
!90 = metadata !{metadata !"/tmp/monniaux/klee/runtime/Intrinsic/memmove.c", metadata !"/tmp/monniaux/klee-build/runtime/Intrinsic"}
!91 = metadata !{metadata !92}
!92 = metadata !{i32 786478, metadata !90, metadata !93, metadata !"memmove", metadata !"memmove", metadata !"", i32 12, metadata !94, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memmove, null, null, metadata !97, i32 1
!93 = metadata !{i32 786473, metadata !90}        ; [ DW_TAG_file_type ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/memmove.c]
!94 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !95, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!95 = metadata !{metadata !78, metadata !78, metadata !79, metadata !96}
!96 = metadata !{i32 786454, metadata !90, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !21} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!97 = metadata !{metadata !98, metadata !99, metadata !100, metadata !101, metadata !102}
!98 = metadata !{i32 786689, metadata !92, metadata !"dst", metadata !93, i32 16777228, metadata !78, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 12]
!99 = metadata !{i32 786689, metadata !92, metadata !"src", metadata !93, i32 33554444, metadata !79, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [src] [line 12]
!100 = metadata !{i32 786689, metadata !92, metadata !"count", metadata !93, i32 50331660, metadata !96, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 12]
!101 = metadata !{i32 786688, metadata !92, metadata !"a", metadata !93, i32 13, metadata !87, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 13]
!102 = metadata !{i32 786688, metadata !92, metadata !"b", metadata !93, i32 14, metadata !42, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 14]
!103 = metadata !{i32 786449, metadata !104, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !105, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/t
!104 = metadata !{metadata !"/tmp/monniaux/klee/runtime/Intrinsic/mempcpy.c", metadata !"/tmp/monniaux/klee-build/runtime/Intrinsic"}
!105 = metadata !{metadata !106}
!106 = metadata !{i32 786478, metadata !104, metadata !107, metadata !"mempcpy", metadata !"mempcpy", metadata !"", i32 11, metadata !108, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @mempcpy, null, null, metadata !111, 
!107 = metadata !{i32 786473, metadata !104}      ; [ DW_TAG_file_type ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/mempcpy.c]
!108 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !109, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!109 = metadata !{metadata !78, metadata !78, metadata !79, metadata !110}
!110 = metadata !{i32 786454, metadata !104, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !21} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!111 = metadata !{metadata !112, metadata !113, metadata !114, metadata !115, metadata !116}
!112 = metadata !{i32 786689, metadata !106, metadata !"destaddr", metadata !107, i32 16777227, metadata !78, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 11]
!113 = metadata !{i32 786689, metadata !106, metadata !"srcaddr", metadata !107, i32 33554443, metadata !79, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 11]
!114 = metadata !{i32 786689, metadata !106, metadata !"len", metadata !107, i32 50331659, metadata !110, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 11]
!115 = metadata !{i32 786688, metadata !106, metadata !"dest", metadata !107, i32 12, metadata !87, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 12]
!116 = metadata !{i32 786688, metadata !106, metadata !"src", metadata !107, i32 13, metadata !42, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 13]
!117 = metadata !{i32 786449, metadata !118, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !119, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/t
!118 = metadata !{metadata !"/tmp/monniaux/klee/runtime/Intrinsic/memset.c", metadata !"/tmp/monniaux/klee-build/runtime/Intrinsic"}
!119 = metadata !{metadata !120}
!120 = metadata !{i32 786478, metadata !118, metadata !121, metadata !"memset", metadata !"memset", metadata !"", i32 11, metadata !122, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i32, i64)* @memset, null, null, metadata !125, i32
!121 = metadata !{i32 786473, metadata !118}      ; [ DW_TAG_file_type ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/memset.c]
!122 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !123, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!123 = metadata !{metadata !78, metadata !78, metadata !9, metadata !124}
!124 = metadata !{i32 786454, metadata !118, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !21} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!125 = metadata !{metadata !126, metadata !127, metadata !128, metadata !129}
!126 = metadata !{i32 786689, metadata !120, metadata !"dst", metadata !121, i32 16777227, metadata !78, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 11]
!127 = metadata !{i32 786689, metadata !120, metadata !"s", metadata !121, i32 33554443, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 11]
!128 = metadata !{i32 786689, metadata !120, metadata !"count", metadata !121, i32 50331659, metadata !124, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 11]
!129 = metadata !{i32 786688, metadata !120, metadata !"a", metadata !121, i32 12, metadata !130, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 12]
!130 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !131} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!131 = metadata !{i32 786485, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !44} ; [ DW_TAG_volatile_type ] [line 0, size 0, align 0, offset 0] [from char]
!132 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!133 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!134 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!135 = metadata !{i32 6, i32 0, metadata !136, null}
!136 = metadata !{i32 786443, metadata !1, metadata !4, i32 6, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/t/teharia/Documents/MOCA/TP8/src/keygenning_klee/test1.c]
!137 = metadata !{i32 7, i32 0, metadata !136, null}
!138 = metadata !{i32 8, i32 0, metadata !139, null} ; [ DW_TAG_imported_declaration ]
!139 = metadata !{i32 786443, metadata !1, metadata !136, i32 8, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/t/teharia/Documents/MOCA/TP8/src/keygenning_klee/test1.c]
!140 = metadata !{i32 9, i32 0, metadata !139, null}
!141 = metadata !{i32 10, i32 0, metadata !4, null}
!142 = metadata !{i32 11, i32 0, metadata !4, null}
!143 = metadata !{i32 17, i32 0, metadata !10, null}
!144 = metadata !{i32 18, i32 0, metadata !10, null}
!145 = metadata !{i32 14, i32 0, metadata !16, null}
!146 = metadata !{i32 17, i32 0, metadata !147, null}
!147 = metadata !{i32 786443, metadata !14, metadata !16, i32 17, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/klee_choose.c]
!148 = metadata !{metadata !149, metadata !149, i64 0}
!149 = metadata !{metadata !"long", metadata !150, i64 0}
!150 = metadata !{metadata !"omnipotent char", metadata !151, i64 0}
!151 = metadata !{metadata !"Simple C/C++ TBAA"}
!152 = metadata !{i32 18, i32 0, metadata !147, null}
!153 = metadata !{i32 19, i32 0, metadata !16, null}
!154 = metadata !{i32 13, i32 0, metadata !155, null}
!155 = metadata !{i32 786443, metadata !26, metadata !28, i32 13, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/klee_div_zero_check.c]
!156 = metadata !{i32 14, i32 0, metadata !155, null}
!157 = metadata !{i32 15, i32 0, metadata !28, null}
!158 = metadata !{i32 15, i32 0, metadata !38, null}
!159 = metadata !{i32 16, i32 0, metadata !38, null}
!160 = metadata !{metadata !161, metadata !161, i64 0}
!161 = metadata !{metadata !"int", metadata !150, i64 0}
!162 = metadata !{i32 21, i32 0, metadata !163, null}
!163 = metadata !{i32 786443, metadata !49, metadata !51, i32 21, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/klee_overshift_check.c]
!164 = metadata !{i32 27, i32 0, metadata !165, null}
!165 = metadata !{i32 786443, metadata !49, metadata !163, i32 21, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/klee_overshift_check.c]
!166 = metadata !{i32 29, i32 0, metadata !51, null}
!167 = metadata !{i32 16, i32 0, metadata !168, null}
!168 = metadata !{i32 786443, metadata !60, metadata !62, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/klee_range.c]
!169 = metadata !{i32 17, i32 0, metadata !168, null}
!170 = metadata !{i32 19, i32 0, metadata !171, null}
!171 = metadata !{i32 786443, metadata !60, metadata !62, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/klee_range.c]
!172 = metadata !{i32 22, i32 0, metadata !173, null}
!173 = metadata !{i32 786443, metadata !60, metadata !171, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/klee_range.c]
!174 = metadata !{i32 25, i32 0, metadata !175, null}
!175 = metadata !{i32 786443, metadata !60, metadata !173, i32 25, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/klee_range.c]
!176 = metadata !{i32 26, i32 0, metadata !177, null}
!177 = metadata !{i32 786443, metadata !60, metadata !175, i32 25, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/klee_range.c]
!178 = metadata !{i32 27, i32 0, metadata !177, null}
!179 = metadata !{i32 28, i32 0, metadata !180, null}
!180 = metadata !{i32 786443, metadata !60, metadata !175, i32 27, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/klee_range.c]
!181 = metadata !{i32 29, i32 0, metadata !180, null}
!182 = metadata !{i32 32, i32 0, metadata !173, null}
!183 = metadata !{i32 34, i32 0, metadata !62, null}
!184 = metadata !{i32 16, i32 0, metadata !74, null}
!185 = metadata !{i32 17, i32 0, metadata !74, null}
!186 = metadata !{metadata !186, metadata !187, metadata !188}
!187 = metadata !{metadata !"llvm.vectorizer.width", i32 1}
!188 = metadata !{metadata !"llvm.vectorizer.unroll", i32 1}
!189 = metadata !{metadata !150, metadata !150, i64 0}
!190 = metadata !{metadata !190, metadata !187, metadata !188}
!191 = metadata !{i32 18, i32 0, metadata !74, null}
!192 = metadata !{i32 16, i32 0, metadata !193, null}
!193 = metadata !{i32 786443, metadata !90, metadata !92, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/memmove.c]
!194 = metadata !{i32 19, i32 0, metadata !195, null}
!195 = metadata !{i32 786443, metadata !90, metadata !92, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/memmove.c]
!196 = metadata !{i32 20, i32 0, metadata !197, null}
!197 = metadata !{i32 786443, metadata !90, metadata !195, i32 19, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/memmove.c]
!198 = metadata !{metadata !198, metadata !187, metadata !188}
!199 = metadata !{metadata !199, metadata !187, metadata !188}
!200 = metadata !{i32 22, i32 0, metadata !201, null}
!201 = metadata !{i32 786443, metadata !90, metadata !195, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/tmp/monniaux/klee-build/runtime/Intrinsic//tmp/monniaux/klee/runtime/Intrinsic/memmove.c]
!202 = metadata !{i32 24, i32 0, metadata !201, null}
!203 = metadata !{i32 23, i32 0, metadata !201, null}
!204 = metadata !{metadata !204, metadata !187, metadata !188}
!205 = metadata !{metadata !205, metadata !187, metadata !188}
!206 = metadata !{i32 28, i32 0, metadata !92, null}
!207 = metadata !{i32 15, i32 0, metadata !106, null}
!208 = metadata !{i32 16, i32 0, metadata !106, null}
!209 = metadata !{metadata !209, metadata !187, metadata !188}
!210 = metadata !{metadata !210, metadata !187, metadata !188}
!211 = metadata !{i32 17, i32 0, metadata !106, null}
!212 = metadata !{i32 13, i32 0, metadata !120, null}
!213 = metadata !{i32 14, i32 0, metadata !120, null}
!214 = metadata !{i32 15, i32 0, metadata !120, null}
