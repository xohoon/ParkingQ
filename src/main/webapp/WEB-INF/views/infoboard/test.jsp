<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<h1 class="mb-0">
	Clarence <span class="text-primary">Taylor</span>
</h1>
<div class="subheading mb-5">
	3542 Berry Street · Cheyenne Wells, CO 80810 · (317) 585-8468 · <a href="mailto:name@email.com">name@email.com</a>

	<!-- 버튼 -->
	<button class="btn btn-primary" data-toggle="modal" data-target="#regModal">글쓰기</button>


</div>
<p class="lead mb-5">I am experienced in leveraging agile frameworks to provide a robust synopsis for high level overviews. Iterative approaches to corporate strategy foster collaborative thinking to further the overall value proposition.</p>
<div class="social-icons">
	<a href="#"> <i class="fab fa-linkedin-in"></i>
	</a> <a href="#"> <i class="fab fa-github"></i>
	</a> <a href="#"> <i class="fab fa-twitter"></i>
	</a> <a href="#"> <i class="fab fa-facebook-f"></i>
	</a>
</div>


<!-- Modal  추가 -->
<div class="modal fade" id="regModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">게시글 작성</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">




				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default">


							<form role="form" action="/board/register" method="post">
								<div class="form-group">
									<label>Title</label> <input class="form-control" name='title'>
								</div>

								<div class="form-group">
									<label>Text area</label>
									<textarea class="form-control" rows="3" name='content'></textarea>
								</div>

								<div class="form-group">
									<label>Writer</label> <input class="form-control" name='writer'>
								</div>
							</form>

						</div>
						<!--  end panel-body -->

					</div>
					<!--  end panel-body -->
				</div>
				<!-- end panel -->
			</div>
			<!-- /.row -->


			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary">Save changes</button>
			</div>


		</div>

	</div>
	<!-- /.modal-content -->
</div>
<!-- /.modal-dialog -->
</div>
<!-- /.modal -->