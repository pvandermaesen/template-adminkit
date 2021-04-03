<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><c:if test="${empty menuCurrentPage}">
	<c:set var="menuCurrentPage" value="${info.templateRoot}" scope="request" />
</c:if>
<c:if test="${not empty menuDepth}">
	<c:set var="menuDepth" value="${menuDepth+1}" scope="request" />
</c:if>
<c:if test="${empty menuDepth}">
	<c:set var="menuDepth" value="1" scope="request" />
</c:if>
<c:if test="${fn:length(menuCurrentPage.children)>0}">
	<c:if test="${param._menufix}"><div class="menu_back_block"></div></c:if>
	<nav id="main-nav" class="${param._menufix?'fixed-top':'notfixeed-top'} ${empty info.userName?'not-logged':'logged'} flex-fill">
		<c:if test="${!param._menularge}"><div class="main-nav"></c:if>
		<div class="navbar navbar-javlo navbar-light navbar-expand-lg ${param._menularge?'large-menu':'small-menu'}">
		<div class="navbar-mobile">
			<div class="btn-group" role="group">
				<a class="btn btn-${info.homePage?'primary':'secondary'} btn-home" href="${info.rootURL}">
					<i class="fas fa-home"></i>
				</a>
				<c:if test="${not empty info.searchPageUrl}">
					<a class="btn btn-${info.searchPage?'primary':'secondary'} btn-search" href="${info.searchPageUrl}">
						<i class="fas fa-search"></i>
					</a>
				</c:if>
				<c:if test="${not empty info.newsPageUrl}">
					<a class="btn btn-${info.newsPage?'primary':'secondary'} btn-register" href="${info.newsPageUrl}">
						<i class="fas fa-rss"></i>
					</a>
				</c:if>
				<c:if test="${not empty info.registerPageUrl}">
					<a class="btn btn-${info.registerPage?'primary':'secondary'} btn-register" href="${info.registerPageUrl}">
						<i class="fas fa-user-cog"></i>
					</a>
				</c:if>
				<c:if test="${not empty info.loginPageUrl && !info.loginPageUrl == info.registerPageUrl}">
					<a class="btn btn-${info.loginPage?'primary':'secondary'} btn-register" href="${info.loginPageUrl}">
						<i class="fas fa-sign-in-alt"></i>
					</a>
				</c:if>			
				<button class="btn navbar-toggler" type="button" data-toggle="collapse" data-target="#mainNavBar" aria-controls="mainNavBar" aria-expanded="false" aria-label="${i18n.view['global.menu']}" lang="en">
					<span class="navbar-toggler-icon"></span>
				</button>
			</div>
		</div>
		<div class="collapse navbar-collapse justify-content-between" id="mainNavBar">
			<div class="navbar navbar-expand-lg justify-content-${not empty param.menuposition?param.menuposition:'end'}">				
				<ul class="justify-content-${not empty param.menuposition?param.menuposition:'end'} navbar-nav ${menuDepth>1?' dropdown-menu':''}">
					<c:set var="index" value="1" />					
					<c:forEach var="child" items="${menuCurrentPage.children}" varStatus="status">
						<c:if test="${child.visibleForContext && not empty child.link}">
							<c:set var="dropdown" value="${param._menudropdown && child.visibleChildren}" />
							<c:if test="${param.subchild && child.selected}"><c:set var="selectedSubChild" value="${child}" /></c:if>
							<li	class="nav-item read-${child.readAccess} ${dropdown?'dropdown ':''}page_${child.name} depth-${menuDepth} index-${status.index}${status.last?' last-item':''} ${child.realContent?'real-content ':'not-real-content '}${child.selected?contentContext.currentTemplate.selectedClass:''}${fn:length(child.children)>0?' has-children':' no-children'}${child.lastSelected?' last-item':''} item-${index}">
								<a class="nav-link ${dropdown?'dropdown-toggle ':''}" ${dropdown?'data-toggle="dropdown"':''} ${!child.realContent && info.openExternalLinkAsPopup && not empty child.linkOn?'target="_blank"':''} href="${child.link}" data-page="${child.name}" title="${child.info.title}">
									${child.info.label} <c:if test="${child.selected}"><span class="sr-only">(${i18n.view['global.current-page']})</span></c:if>
								</a>
								<c:if test="${dropdown}">
									<div class="dropdown-menu">
									<c:forEach var="subchild" items="${child.children}" varStatus="substatus">
										<a class="dropdown-item" href="${subchild.url}">${subchild.info.label}</a>
									</c:forEach>
									</div>
								</c:if>
							</li>
							<c:set var="index" value="${index+1}" />
						</c:if>
					</c:forEach>					
				</ul></div>
				<c:if test="${not empty selectedSubChild}">
					<div class="navbar navbar-expand-lg justify-content-${not empty param.menuposition?param.menuposition:'end'} subchild">
						<ul class="justify-content-end navbar-nav ${menuDepth>1?' dropdown-menu':''} nav-pills">
							<c:set var="index" value="1" />					
							<c:forEach var="child" items="${selectedSubChild.children}" varStatus="status">
								<c:if test="${child.visibleForContext && not empty child.link}">
									<c:set var="dropdown" value="${param._menudropdown && child.visibleChildren}" />
									<c:if test="${child.selected}"><c:set var="selectedSubChild" value="${child}" /></c:if>
									<li	class="nav-item read-${child.readAccess} ${dropdown?'dropdown ':''}page_${child.name} depth-${menuDepth} index-${status.index}${status.last?' last-item':''} ${child.realContent?'real-content ':'not-real-content '}${child.selected?contentContext.currentTemplate.selectedClass:''}${fn:length(child.children)>0?' has-children':' no-children'}${child.lastSelected?' last-item':''} item-${index}">
										<a class="nav-link ${dropdown?'dropdown-toggle ':''}" ${dropdown?'data-toggle="dropdown"':''} ${!child.realContent && info.openExternalLinkAsPopup && not empty child.linkOn?'target="_blank"':''} href="${child.link}" data-page="${child.name}" title="${child.info.title}">
											${child.info.label} <c:if test="${child.selected}"><span class="sr-only">(${i18n.view['global.current-page']})</span></c:if>
										</a>
										<c:if test="${dropdown}">
											<div class="dropdown-menu">
											<c:forEach var="subchild" items="${child.children}" varStatus="substatus">
												<a class="dropdown-item" href="${subchild.url}">${subchild.info.label}</a>
											</c:forEach>
											</div>
										</c:if>
									</li>
									<c:set var="index" value="${index+1}" />
								</c:if>
							</c:forEach>
						</ul>
					</div>
				</c:if>
				
				</div>

				<c:if test="${fn:length(info.languages)>1}">
				<div class="my-2 my-lg-0 lang-bloc">
					<div class="btn-group" role="group" aria-label="${vi18n['global.change-language']}">
					<c:forEach var="lg" items="${info.languages}">
					<a class="btn btn${lg!=info.language?'-outline':''}-secondary my-2 my-sm-0 btn-sm btn-lang" href="${info.languageURLs[lg]}" title="${info.languageMap[lg]}" lang="${lg}">${lg}</a>
					</c:forEach>
					</div>
				</div></c:if>

				<c:if test="${param._menujssearch || param._menusearch || param._menulogin}">
					<div class="nav-action-block">
				</c:if>
				<c:if test="${param._menujssearch}">
				<div class="my-2 my-lg-0 search-bloc collapse-bloc">
					<button class="btn btn-outline-secondary my-2 my-sm-0 btn-sm" data-toggle="collapse" data-target="#searchForm" aria-expanded="false" aria-controls="searchForm" title="${i18n.view['global.open-search']}"><i class="fas fa-search"></i></button>
					<div id="searchForm" class="collapse">
						<div class="card card-body">
							<form id="search-form">
								<input name="webaction" value="search.search" type="hidden" />
								<div class="input-group">
				            	<input id="staticSearchButton" class="form-control" type="text" placeholder="${i18n.view['global.search']}" aria-label="${i18n.view['global.search']}" accesskey="4" name="keywords">
				            	<div class="input-group-append">
				            	<button class="btn btn-outline-secondary" type="submit"><i class="fas fa-angle-double-right" aria-hidden="true"></i><span class="sr-only">${i18n.view['global.send']}</span></button>
				            	</div>
				            	<div id="staticSearchResult"></div>
				            	<a href="${info.staticRootURL}/sitemap.json" style="display: none;" id="staticSearchData">staticSeach data</a>
				            	</div>
				            </form>
			            </div>
		            </div>
	         	</div></c:if><c:if test="${param._menusearch}">
				<div class="my-2 my-lg-0 search-bloc collapse-bloc">
					<button class="btn btn-outline-secondary my-2 my-sm-0 btn-sm" data-toggle="collapse" data-target="#searchForm" aria-expanded="false" aria-controls="searchForm" title="${i18n.view['global.open-search']}"><i class="fas fa-search"></i></button>
					<div id="searchForm" class="collapse">
						<div class="card card-body">
							<form id="search-form" action="${not empty info.searchPageUrl?info.searchPageUrl:info.currentPageURL}">
								<input name="webaction" value="search.search" type="hidden" />
								<div class="input-group">
				            	<input class="form-control" type="text" placeholder="${i18n.view['global.search']}" aria-label="${i18n.view['global.search']}" accesskey="4" name="keywords">
				            	<div class="input-group-append">
				            	<button class="btn btn-outline-secondary" type="submit"><i class="fas fa-angle-double-right" aria-hidden="true"></i><span class="sr-only">${i18n.view['global.send']}</span></button>
				            	</div>
				            	</div>
				            </form>
			            </div>
		            </div>
				</div></c:if>
				<c:if test="${param._menulogin}">
				<div class="my-2 my-lg-0 login-bloc collapse-bloc">
					<button class="btn btn-outline-secondary my-2 my-sm-0 btn-sm btn-user d-none-logged" data-toggle="collapse" data-target="#loginForm" aria-expanded="false" aria-controls="loginForm" title="${i18n.view['login.nologin']}"><i class="fas fa-user-times"></i></button>
					<button class="btn btn-outline-secondary my-2 my-sm-0 btn-sm btn-user d-logged" data-toggle="collapse" data-target="#loginForm" aria-expanded="false" aria-controls="loginForm"><i class="fas fa-user-check"></i></button>
					<div id="loginForm" class="collapse"><jsp:include page="menu_login.jsp?noAjaxMenuLogin=true" /></div>
				</div></c:if>
				<c:if test="${param._menujssearch || param._menusearch || param._menulogin}">
					</div>
				</c:if>				
	</div>
	<c:if test="${!param._menularge}"></div></c:if>
	</nav>	
</c:if>
<c:set var="menuDepth" value="${menuDepth-1}" scope="request" />