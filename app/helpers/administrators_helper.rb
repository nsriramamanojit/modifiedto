module AdministratorsHelper
  def admin_header(&block)
    concat('<div id="headercontainer">
      <div id="logo"><img src="/images/logo.png" alt="LSSSA"  width="160" length="69"/></div>
        <div id="headerright">
          <div id="headermenu"><a href="/admin/examtype/welcome">Home</a></div>
            <div id="headercaption">Administrator Control Panel</div>
        </div>
  </div>', block.binding)
  end   
def admin_navigation(&block)
    concat('<div id="menu">
<ul class="level1" id="root">
<li class="sep"></li>
<li><a href="/admin/examtype/welcome">Home</a></li>


<li><a href="#">Settings </a>
<ul class="level2">
<li><a href="#">Examtype</a>
<ul class="level3">
<li><a href="/admin/examtype/list">List Exam Types</a></li>
<li><a href="/admin/examtype/new">Create ExamType</a></li>
</ul></li>
<li><a href="#">Subjects</a>
<ul class="level3">
<li><a href="/admin/subject/list">List Subjects</a></li>
<li><a href="/admin/subject/new">Create Subject</a></li>
</ul></li>
<li><a href="#">Questions</a>
<ul class="level3">
<li><a href="#">List Questions</a></li>
<li><a href="/admin/questionbank/new">Create Question</a></li>
</ul></li>
<li><a href="#">Exam Templates</a>
<ul class="level3">
<li><a href="/admin/examtemplates">List Exam Templates</a></li>
<li><a href="/admin/examtemplates/new">Create Exam Template</a></li>
</ul></li>
<li><a href="#">Section Templates</a>
<ul class="level3">
<li><a href="/admin/sectiontemplates">List Section Templates</a></li>
<li><a href="/admin/sectiontemplates/new">Create Section Template</a></li>
</ul></li>
<li><a href="#">Section Topics</a>
<ul class="level3">
<li><a href="/admin/sectiontopic/list">List Section Topics</a></li>
<li><a href="/admin/sectiontopic/new">Create Section Topic</a></li>
</ul></li>
<li><a href="#">Exam</a>
<ul class="level3">
<li><a href="/admin/exams">List Exams</a></li>
<li><a href="/admin/exams/new">Create Exam</a></li>
</ul></li>
<li><a href="#">Exam Schedules</a>
<ul class="level3">
<li><a href="/admin/examschedules">List Exam Schedules</a></li>
<li><a href="/admin/examschedules/new">Create Exam Schedule</a></li>
</ul></li>
<li><a href="#">Service Types</a>
<ul class="level3">
<li><a href="/admin/servicetypes">List Service Types</a></li>
<li><a href="/admin/servicetypes/new">Create Service Type</a></li>
</ul></li>
<li><a href="#">Services</a>
<ul class="level3">
<li><a href="/admin/services">List Services </a></li>
<li><a href="/admin/services/new">Create Service</a></li>
</ul></li>

</ul>
</li>
<li><a href="#">Users </a>
<ul class="level2">
<li><a href="/administrators/new">Create User </a>
<li><a href="/administrators">List Users </a>
</ul>
<li><a href="#">Search </a>
<ul class="level2">
<li><a href="/admin/questionbank/search_by_ref_num">Question By Ref Num </a>
<li><a href="/admin/questionbank/search_by_tags">Question By Tags </a>
<li><a href="/admin/questionbank/search_by_code">Question By Code </a>
<li><a href="/admin/questionbank/search_by_que_num">Question By Number </a>
</ul>

<li><a href="#">User Status</a>
<ul class="level2">
<li><a href="/admin/userstatus/regdusers">Registered Users</a>
<li><a href="/admin/userstatus/activeusers">Activated Users</a>
<li><a href="/admin/userstatus/pendingusers">Pending Users</a>
<li><a href="/admin/userstatus/paidusers">Paid Users</a>
</ul>

<li><a href="/admin/login/logout">Signout </a></li>
</ul>
</div>
', block.binding)
end  

def admin_relavant_info(objects,&block)
    concat('<div id="shellright">
       <h1>Relevant Information</h1>
          <div id="register">', block.binding)
        for object in objects
          yield(object)
      end
      concat('</div></div>', block.binding)
end  
def user_relavant_info(objects,&block)
    concat('<div id="shellright">
          <div id="register">', block.binding)
        for object in objects
          yield(object)
      end
      concat('</div></div>', block.binding)
end


def admin_footer(&block)
    concat(' <div id="footer" align="center">
    <p>Copyright &copy; 2011.All rights reserved. <br />
    Best viewed in 1024X768 screen resolution.</a>     
    </div>
</div>', block.binding)
end  
end
