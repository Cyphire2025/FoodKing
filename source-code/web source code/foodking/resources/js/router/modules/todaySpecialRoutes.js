const TodaySpecialComponent = () => import("../../components/admin/todaySpecial/TodaySpecialComponent");

export default [
    {
        path: '/admin/todays-special',
        component: TodaySpecialComponent,
        name: 'admin.todays-special',
        meta: {
            isFrontend: false,
            auth: true,
            permissionUrl: 'items',
            breadcrumb: 'todays_special'
        },
    }
]
